#! /usr/bin/python

"""

    darcs2git -- Darcs to git converter.

    Copyright (c) 2007 Han-Wen Nienhuys <hanwen@xs4all.nl>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

"""

# TODO:
#
# - time zones
#
# - file modes
#
# - use binary search to find from-patch in case of conflict.
#

import sha
from datetime import datetime
from time import strptime
import urlparse
import distutils.version
import glob
import os  
import sys
import time
import xml.dom.minidom
import re
import gzip
import optparse


################################################################
# globals


log_file = None
options = None
mail_to_name_dict = {}
pending_patches = {}
git_commits = {}
used_tags = {}

################################################################
# utils

class PullConflict (Exception):
    pass
class CommandFailed (Exception):
    pass

def progress (s):
    sys.stderr.write (s + '\n')
    
def get_cli_options ():
    class MyOP(optparse.OptionParser):
        def print_help(self):
            optparse.OptionParser.print_help (self)
            print '''
DESCRIPTION

This tool is a conversion utility for Darcs repositories, importing
them in chronological order.  It requires a Git version that has
git-fast-import.  It does not support incremental updating.  

BUGS

 * repositories with skewed timestamps, or different patches with
 equal timestamps will confuse darcs2git.
 * does not respect file modes or time zones.
 * too slow. See source code for instructions to speed it up.
 * probably doesn\'t work on partial repositories

Report new bugs to hanwen@xs4all.nl

LICENSE

Copyright (c) 2007 Han-Wen Nienhuys <hanwen@xs4all.nl>.
Distributed under terms of the GNU General Public License
This program comes with NO WARRANTY.
'''

    p = MyOP ()

    p.usage='''darcs2git [OPTIONS] DARCS-REPO'''
    p.description='''Convert darcs repo to git.'''

    def update_map (option, opt, value, parser):
        for l in open (value).readlines ():
            (mail, name) = tuple (l.strip ().split ('='))
            mail_to_name_dict[mail] = name

    p.add_option ('-a', '--authors', action='callback',
                  callback=update_map,
                  type='string',
                  nargs=1,
                  help='read a text file, containing EMAIL=NAME lines')

    p.add_option ('--checkpoint-frequency', action='store',
                  dest='checkpoint_frequency',
                  type='int',
                  default=0,
                  help='how often should the git importer be synced?\n'
                  'Default is 0 (no limit)'
                  )

    p.add_option ('-d', '--destination', action='store',
                  type='string',
                  default='',
                  dest='target_git_repo',
                  help='where to put the resulting Git repo.')

    p.add_option ('--verbose', action='store_true',
                  dest='verbose',
                  default=False, 
                  help='show commands as they are invoked')

    p.add_option ('--history-window', action='store',
                  dest='history_window',
                  type='int',
                  default=0, 
                  help='Look back this many patches as conflict ancestors.\n'
                  'Default is 0 (no limit)')

    p.add_option ('--debug', action='store_true',
                  dest='debug',
                  default=False, 
                  help="""add patch numbers to commit messages;
don\'t clean conversion repo;
test end result.""")

    global options
    options, args = p.parse_args ()
    if not args:
        p.print_help ()
        sys.exit (2)

    if len(urlparse.urlparse(args[0])) == 0:
        raise NotImplementedError, "We support local DARCS repos only."

    git_version = distutils.version.LooseVersion(
        os.popen("git --version","r").read().strip().split(" ")[-1])
    ideal_version = distutils.version.LooseVersion("1.5.0")
    if git_version<ideal_version:
        raise RuntimeError,"You need git >= 1.5.0 for this."
    
    options.basename = os.path.basename (
        os.path.normpath (args[0])).replace ('.darcs', '')
    if not options.target_git_repo:
        options.target_git_repo = options.basename + '.git'
        
    if options.debug:
        global log_file
        name = options.target_git_repo.replace ('.git', '.log')
        if name == options.target_git_repo:
            name += '.log'
            
        progress ("Shell log to %s" % name)
        log_file = open (name, 'w')
        
    return (options, args)

def read_pipe (cmd, ignore_errors=False):
    if options.verbose:
        progress ('pipe %s' % cmd)
    pipe = os.popen (cmd)

    val = pipe.read ()
    if pipe.close () and not ignore_errors:
        raise CommandFailed ("Pipe failed: %s" % cmd)
    
    return val

def system (c, ignore_error=0, timed=0):
    if timed:
        c = "time " + c
    if options.verbose:
        progress (c)

    if log_file:
        log_file.write ('%s\n' % c)
        log_file.flush ()
        
    if os.system (c) and not ignore_error:
        raise CommandFailed ("Command failed: %s" % c)

def darcs_date_to_git (x):
    t = time.strptime (x, '%Y%m%d%H%M%S')
    return '%d' % int (time.mktime (t))

def darcs_timezone (x) :
    time.strptime (x, '%a %b %d %H:%M:%S %Z %Y')

    # todo
    return "+0100"

################################################################
# darcs

## http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/521889

PATCH_DATE_FORMAT = '%Y%m%d%H%M%S'

patch_pattern = r"""
   \[                                   # Patch start indicator
   (?P<name>[^\n]+)\n                   # Patch name (rest of same line)
   (?P<author>[^\*]+)                   # Patch author
   \*                                   # Author/date separator 
   (?P<inverted>[-\*])                  # Inverted patch indicator
   (?P<date>\d{14})                     # Patch date
   (?:\n(?P<comment>(?:^\ [^\n]*\n)+))? # Optional long comment
   \]                                   # Patch end indicator
   """
patch_re = re.compile(patch_pattern, re.VERBOSE | re.MULTILINE)
tidy_comment_re = re.compile(r'^ ', re.MULTILINE)

def parse_inventory(inventory):
    """
    Given the contents of a darcs inventory file, generates ``Patch``
    objects representing contained patch details.
    """
    for match in patch_re.finditer(inventory):
        attrs = match.groupdict(None)
        attrs['inverted'] = (attrs['inverted'] == '-')
        if attrs['comment'] is not None:
            attrs['comment'] = tidy_comment_re.sub('', attrs['comment']).strip()
        yield InventoryPatch(**attrs)

def fix_braindead_darcs_escapes(s):
    def insert_hibit(match):
        return chr(int(match.group(1), 16))
        
    return re.sub(r'\[_\\([0-9a-f][0-9a-f])_\]',
           insert_hibit, str(s))

class InventoryPatch:
    """
    Patch details, as defined in a darcs inventory file.

    Attribute names match those generated by the
    ``darcs changes --xml-output`` command.
    """

    def __init__(self, name, author, date, inverted, comment=None):
        self.name = name
        self.author = author
        self.date = datetime(*strptime(date, PATCH_DATE_FORMAT)[:6])
        self.inverted = inverted
        self.comment = comment

    def __str__(self):
        return self.name

    @property
    def complete_patch_details(self):
        date_str = self.date.strftime(PATCH_DATE_FORMAT)
        return '%s%s%s%s%s' % (
            self.name, self.author, date_str,
            self.comment and ''.join([l.rstrip() for l in self.comment.split('\n')]) or '',
            self.inverted and 't' or 'f')

    def short_id (self):
        inv = '*'
        if self.inverted:
            inv = '-'
        
        return unicode('%s%s*%s%s' % (self.name, self.author, inv, self.hash.split ('-')[0]), 'UTF-8')
    
    @property 
    def hash(self):
        """
        Calculates the filename of the gzipped file containing patch
        contents in the repository's ``patches`` directory.

        This consists of the patch date, a partial SHA-1 hash of the
        patch author and a full SHA-1 hash of the complete patch
        details.
        """
   
        date_str = self.date.strftime(PATCH_DATE_FORMAT)
        return '%s-%s-%s.gz' % (date_str,
                                sha.new(self.author).hexdigest()[:5],
                                sha.new(self.complete_patch_details).hexdigest())

## http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/521889
        
class DarcsConversionRepo:
    """Representation of a Darcs repo.

The repo is thought to be ordered, and supports methods for
going back (obliterate) and forward (pull).

    """

    def __init__ (self, dir, patches):
        self.dir = os.path.abspath (dir)
        self.patches = patches
        self._current_number = -1
        self._is_valid = -1
        self._inventory_dict = None
        self._short_id_dict = dict ((p.short_id (), p) for p in patches)

    def __del__ (self):
        if not options.debug:
            system ('rm -fr %s' % self.dir)
        
    def is_contiguous (self):
        return (len (self.inventory_dict ()) == self._current_number + 1
                and self.contains_contiguous (self._current_number))

    def contains_contiguous (self, num):
        if not self._is_valid:
            return False
        
        darcs_dir = self.dir + '/_darcs'
        if not os.path.exists (darcs_dir):
            return False
        
        for p in self.patches[:num + 1]:
            if not self.has_patch (p):
                return False
        
        return True
    
    def has_patch (self, p):
        assert self._is_valid
        
        return p.short_id () in self.inventory_dict ()
    
    def pristine_tree (self):
        return self.dir + '/_darcs/pristine'
    
    def go_back_to (self, dest):

        # at 4, len = 5, go to 2: count == 2
        count = len (self.inventory_dict()) - dest - 1

        assert self._is_valid
        assert count > 0
        
        self.checkout ()
        dir = self.dir

        progress ('Rewinding %d patches' % count)
        system ('cd %(dir)s && darcs revert --all' % locals())
        system ('cd %(dir)s && yes|darcs obliterate -a --ignore-times --last %(count)d' % locals ())
        system ('cd %(dir)s && darcs revert -a' % locals())
        d = self.inventory_dict () 
        for p in self.patches[dest+1:self._current_number+1]:
            try:
                del d[p.short_id ()]
            except KeyError:
                pass

        self._current_number = dest
        
    def clean (self):
        system ('rm -rf %s' % self.dir)

    def checkout (self):
        dir = self.dir
        system ('rsync -a  %(dir)s/_darcs/pristine/ %(dir)s/' % locals ())

    def pull (self, patch):
        id = patch.attributes['hash']
        source_repo = patch.dir
        dir = self.dir

        progress ('Pull patch %d' % patch.number)
        system ('cd %(dir)s && darcs revert --all' % locals())
        system ('cd %(dir)s && darcs pull --ignore-times --quiet --all --match "hash %(id)s" %(source_repo)s ' % locals ())

        self._current_number = patch.number

        ## must reread: the pull may have pulled in others.
        self._inventory_dict = None

    def go_forward_to (self, num):
        d = self.inventory_dict ()

        pull_me = []

        ## ugh
        for p in self.patches[0:num+1]:
            if not d.has_key (p.short_id ()):
                pull_me.append (p)
                d[p.short_id ()] = p

        pull_str = ' || '.join (['hash %s' % p.id () for p in pull_me])
        dir = self.dir
        src = self.patches[0].dir

        progress ('Pulling %d patches to go to %d' % (len (pull_me), num))
        system ('darcs revert --repo %(dir)s  --all' % locals ())
        system ('darcs pull --all --repo %(dir)s --match "%(pull_str)s" %(src)s' % locals ())
        
    def create_fresh (self):
        dir = self.dir
        system ('rm -rf %(dir)s && mkdir %(dir)s && darcs init --repo  %(dir)s'
                % locals ())
        self._is_valid = True
        self._current_number = -1
        self._inventory_dict = {}
        
    def inventory (self):
        darcs_dir = self.dir + '/_darcs'
        i = ''
        for f in [darcs_dir + '/inventory'] + glob.glob (darcs_dir + '/inventories/*'):
            i += open (f).read ()
        return i

    def inventory_dict (self):
        
        if type (self._inventory_dict) != type ({}):
            self._inventory_dict = {}

            for p in parse_inventory(self.inventory()):
                key = p.short_id()
                
                try:
                    self._inventory_dict[key] = self._short_id_dict[key]
                except KeyError:
                    print 'key not found', key
                    print self._short_id_dict
                    raise

        return self._inventory_dict

    def start_at (self, num):
        """Move the repo to NUM.

        This uses the fishy technique of writing the inventory and
        constructing the pristine tree with 'darcs repair'
        """
        progress ('Starting afresh at %d' % num)

        self.create_fresh ()
        dir = self.dir
        iv = open (dir + '/_darcs/inventory', 'w')
        if log_file:
            log_file.write ("# messing with _darcs/inventory")
            
        for p in self.patches[:num+1]:
            os.link (p.filename (), dir + '/_darcs/patches/' + os.path.basename (p.filename ()))
            iv.write (p.header ())
            self._inventory_dict[p.short_id ()] = p
        iv.close ()

        system ('darcs revert --repo %(dir)s --all' % locals())
        system ('darcs repair --repo %(dir)s --quiet' % locals ())
        self.checkout ()
        self._current_number = num
        self._is_valid = True

    def go_to (self, dest):
        if not self._is_valid:
            self.start_at (dest)
        elif dest == self._current_number and self.is_contiguous ():
            pass
        elif (self.contains_contiguous (dest)):
            self.go_back_to (dest)
        elif dest - len (self.inventory_dict ()) < dest / 100:
            self.go_forward_to (dest)
        else:
            self.start_at (dest)

            
    def go_from_to (self, from_patch, to_patch):

        """Move the repo to FROM_PATCH, then go to TO_PATCH. Raise
        PullConflict if conflict is detected
        """

        progress ('Trying %s -> %s' % (from_patch, to_patch))
        dir = self.dir
        source = to_patch.dir
        
        if from_patch:
            self.go_to (from_patch.number)
        else:
            self.create_fresh ()
        
        try:
            self.pull (to_patch)
            success = 'No conflicts to resolve' in read_pipe ('cd %(dir)s && echo y|darcs resolve' % locals  ())
        except CommandFailed:
            self._is_valid = False
            raise PullConflict ()

        if not success:
            raise PullConflict ()

class DarcsPatch:
    def __repr__ (self):
        return 'patch %d' % self.number
    
    def __init__ (self, xml, dir):
        self.xml = xml
        self.dir = dir
        self.number = -1
        self.attributes = {}
        self._contents = None
        for (nm, value) in xml.attributes.items():
            self.attributes[nm] = value

        # fixme: ugh attributes vs. methods.
        self.extract_author ()
        self.extract_message ()
        self.extract_time ()

    def id (self):
        return self.attributes['hash']
    
    def short_id (self):
        inv = '*'
        if self.attributes['inverted'] == 'True':
            inv = '-'
            
        return '%s%s*%s%s' % (self.name(), self.attributes['author'], inv, self.attributes['hash'].split ('-')[0])

    def filename (self):
        return self.dir + '/_darcs/patches/' + self.attributes['hash']

    def contents (self):
        if type (self._contents) != type (''):
            f = gzip.open (self.filename ())
            self._contents = f.read ()

        return self._contents

    def header (self):
        lines = self.contents ().split ('\n')

        name = lines[0]
        committer = lines[1] + '\n'
        committer = re.sub ('] {\n$', ']\n', committer)
        committer = re.sub ('] *\n$', ']\n', committer)
        comment = ''
        if not committer.endswith (']\n'):
            for l in lines[2:]:
                if l[0] == ']':
                    comment += ']\n'
                    break
                comment += l + '\n'

        header = name  + '\n' + committer 
        if comment:
            header += comment

        assert header[-1] == '\n'
        return header

    def extract_author (self):
        mail = self.attributes['author']
        name = ''
        m = re.search ("^(.*) <(.*)>$", mail)

        if m:
            name = m.group (1)
            mail = m.group (2)
        else:
            try:
                name = mail_to_name_dict[mail]
            except KeyError:
                name = mail.split ('@')[0]

        self.author_name = name
        
        # mail addresses should be plain strings.
        self.author_mail = mail.encode('utf-8')

    def extract_time (self):
        self.date = darcs_date_to_git (self.attributes['date']) + ' ' + darcs_timezone (self.attributes['local_date'])

    def name (self):
        patch_name = ''
        try:
            name_elt = self.xml.getElementsByTagName ('name')[0]
            patch_name = unicode(fix_braindead_darcs_escapes(str(name_elt.childNodes[0].data)), 'UTF-8')
        except IndexError:
            pass
        return patch_name
    
    def extract_message (self):
        patch_name = self.name ()
        comment_elts = self.xml.getElementsByTagName ('comment')
        comment = ''
        if comment_elts:
            comment = comment_elts[0].childNodes[0].data

        if self.attributes['inverted'] == 'True':
            patch_name = 'UNDO: ' + patch_name

        self.message = '%s\n\n%s' % (patch_name, comment)
        
    def tag_name (self):
        patch_name = self.name ()
        if patch_name.startswith ("TAG "):
           tag = patch_name[4:]
           tag = re.sub (r'\s', '_', tag).strip ()
           tag = re.sub (r':', '_', tag).strip ()
           return tag
        return ''

def get_darcs_patches (darcs_repo):
    progress ('reading patches.')
    
    xml_string = read_pipe ('darcs changes --xml --reverse --repo ' + darcs_repo)

    dom = xml.dom.minidom.parseString(xml_string)
    xmls = dom.documentElement.getElementsByTagName('patch')

    patches = [DarcsPatch (x, darcs_repo) for x in xmls]

    n = 0
    for p in patches:
        p.number = n
        n += 1

    return patches

################################################################
# GIT export

class GitCommit:
    def __init__ (self, parent, darcs_patch):
        self.parent = parent
        self.darcs_patch = darcs_patch
        if parent:
            self.depth = parent.depth + 1
        else:
            self.depth = 0
        
    def number (self):
        return self.darcs_patch.number
    
    def parent_patch (self):
        if self.parent:
            return self.parent.darcs_patch
        else:
            return None

def common_ancestor (a, b):
    while 1:
        if a.depth < b.depth:
            b = b.parent
        elif a.depth > b.depth:
            a = a.parent
        else:
            break

    while a and b:
        if a == b:
            return a

        a = a.parent
        b = b.parent

    return None

def export_checkpoint (gfi):
    gfi.write ('checkpoint\n\n')
    
def export_tree (tree, gfi):
    tree = os.path.normpath (tree)
    gfi.write ('deleteall\n')
    for (root, dirs, files) in os.walk (tree):
        for f in files:
            rf = os.path.normpath (os.path.join (root, f))
            s = open (rf).read ()
            rf = rf.replace (tree + '/', '')
            
            gfi.write ('M 644 inline %s\n' % rf)
            gfi.write ('data %d\n%s\n' % (len (s), s))
    gfi.write ('\n')

    
def export_commit (repo, patch, last_patch, gfi):
    gfi.write ('commit refs/heads/darcstmp%d\n' % patch.number)
    gfi.write ('mark :%d\n' % (patch.number + 1))

    raw_name = patch.author_name
    gfi.write ('committer %s <%s> %s\n' % (raw_name,
                                           patch.author_mail,
                                           patch.date))

    msg = patch.message
    if options.debug:
        msg += '\n\n#%d\n' % patch.number
        
    msg = msg.encode('utf-8')
    gfi.write ('data %d\n%s\n' % (len (msg), msg))
    mergers = []
    for (n, p) in pending_patches.items ():
        if repo.has_patch (p):
            mergers.append (n)
            del pending_patches[n]
            
    if (last_patch
        and mergers == []
        and git_commits.has_key (last_patch.number)):
        mergers = [last_patch.number]

    if mergers:
        gfi.write ('from :%d\n' % (mergers[0] + 1))
        for m in mergers[1:]:
            gfi.write ('merge :%d\n' % (m + 1))

    pending_patches[patch.number] = patch
    export_tree (repo.pristine_tree (), gfi)

    n = -1
    if last_patch:
        n = last_patch.number
    git_commits[patch.number] = GitCommit (git_commits.get (n, None),
                                           patch)

def export_pending (gfi):
    if len (pending_patches.items ()) == 1:
        gfi.write ('reset refs/heads/master\n')
        gfi.write ('from :%d\n\n' % (pending_patches.values()[0].number+1))

        progress ("Creating branch master")
        return

    for (n, p) in pending_patches.items ():
        gfi.write ('reset refs/heads/master%d\n' % n)
        gfi.write ('from :%d\n\n' % (n+1))

        progress ("Creating branch master%d" % n)

    patches = pending_patches.values()
    patch = patches[0]
    gfi.write ('commit refs/heads/master\n')
    gfi.write ('committer %s <%s> %s\n' % (patch.author_name,
                                           patch.author_mail,
                                           patch.date))
    msg = 'tie together'
    gfi.write ('data %d\n%s\n' % (len(msg), msg))
    gfi.write ('from :%d\n' % (patch.number + 1))
    for p in patches[1:]:
        gfi.write ('merge :%d\n' % (p.number + 1))
    gfi.write ('\n')

def export_tag (patch, gfi):
    gfi.write ('tag %s\n' % patch.tag_name ())
    gfi.write ('from :%d\n' % (patch.number + 1))
    gfi.write ('tagger %s <%s> %s\n' % (patch.author_name,
                                        patch.author_mail,
                                        patch.date))

    raw_message = patch.message.encode('utf-8')
    gfi.write ('data %d\n%s\n' % (len (raw_message),
                                  raw_message))

################################################################
# main.

def test_conversion (darcs_repo, git_repo):
    pristine = '%(darcs_repo)s/_darcs/pristine' % locals ()
    if not os.path.exists (pristine):
        progress ("darcs repository does not contain pristine tree?!")
        return
    
    gd = options.basename + '.checkouttmp.git'
    system ('rm -rf %(gd)s && git clone %(git_repo)s %(gd)s' % locals ())
    diff_cmd = 'diff --exclude .git -urN %(gd)s %(pristine)s' % locals ()
    diff = read_pipe (diff_cmd, ignore_errors=True)
    system ('rm -rf %(gd)s' % locals ())
    
    if diff:
        if len (diff) > 1024:
            diff = diff[:512] + '\n...\n'  +  diff[-512:]
        
        progress ("Conversion introduced changes: %s" % diff)
        raise 'fdsa'
    else:
        progress ("Checkout matches pristine darcs tree.")

def main ():
    (options, args) = get_cli_options ()

    darcs_repo = os.path.abspath (args[0])
    git_repo = os.path.abspath (options.target_git_repo)

    if os.path.exists (git_repo):
        system ('rm -rf %(git_repo)s' % locals ())

    system ('mkdir %(git_repo)s && cd %(git_repo)s && git --bare init' % locals ())
    system ('git --git-dir %(git_repo)s  repo-config core.logAllRefUpdates false' % locals ())

    os.environ['GIT_DIR'] = git_repo

    quiet = ' --quiet'
    if options.verbose:
        quiet = ' '
    
    gfi = os.popen ('git-fast-import %s' % quiet, 'w')

    patches = get_darcs_patches (darcs_repo)
    conv_repo = DarcsConversionRepo (options.basename + ".tmpdarcs", patches)
    conv_repo.start_at (-1)

    for p in patches:
        parent_patch = None
        parent_number = -1
        
        combinations = [(v, w) for v in pending_patches.values ()
                        for w in pending_patches.values ()]
        candidates = [common_ancestor (git_commits[c[0].number], git_commits[c[1].number]) for c in combinations]
        candidates = sorted ([(-a.darcs_patch.number, a) for a in candidates])
        for (depth, c) in candidates:
            q = c.darcs_patch
            try:
                conv_repo.go_from_to (q, p)

                parent_patch = q
                parent_number = q.number
                progress ('Found existing common parent as predecessor')
                break

            except PullConflict:
                pass

        ## no branches found where we could attach.
        ## try previous commits one by one.
        if not parent_patch:
            parent_number = p.number - 2
            while 1:
                if parent_number >= 0:
                    parent_patch = patches[parent_number]

                try:
                    conv_repo.go_from_to (parent_patch, p)
                    break
                except PullConflict:
                    
                    ## simplistic, may not be enough.
                    progress ('conflict, going one back')
                    parent_number -= 1

                    if parent_number < 0:
                        break

                    if (options.history_window
                        and parent_number < p.number - options.history_window):

                        parent_number = -2
                        break

        if parent_number >= 0 or p.number == 0:
            progress ('Export %d -> %d (total %d)' % (parent_number,
                                                      p.number, len (patches)))
            export_commit (conv_repo, p, parent_patch, gfi)
            if p.tag_name ():
                export_tag (p, gfi)

            if options.checkpoint_frequency and p.number % options.checkpoint_frequency == 0:
                export_checkpoint (gfi)
        else:
            progress ("Can't import patch %d, need conflict resolution patch?"
                      % p.number)

    export_pending (gfi)
    gfi.close ()
    for f in glob.glob ('%(git_repo)s/refs/heads/darcstmp*' % locals ()):
        os.unlink (f)
        
    test_conversion (darcs_repo, git_repo)

    if not options.debug:
        conv_repo.clean ()

main ()
