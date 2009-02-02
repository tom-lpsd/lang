#!/usr/bin/perl -w

use strict;
use encoding 'utf8', STDIN => 'euc-jp';
use HTML::Template;
use CGI qw/:standard:/;

my $q = new CGI;
print $q->header(-type=>'text/html', -charset=>'euc-jp');

my $index_char = qr(^\s*●(.*)\s*);
my $template = HTML::Template->new(filename => "index.tmpl");
# $template->param(PAGENAME => $ENV{PATH_INFO});

my @titles = ();
my @indexes = ();
my $ichigyoume;

open (STDIN,"<$ENV{PATH_TRANSLATED}") or die "Can't open readme file! : $!";
$ichigyoume=<>;
$template->param(PAGENAME => $ichigyoume );
while(<>) {
  next if /^-+$/;
  if ( /$index_char/) {
    my @dlists = ();
    my $title = $1;

    while(<>) {
      if(/([^:：]+)[:：](.+)/ ) {
	my ($dtitle, $dbody) = ($1, "$2<br />");
	push @dlists, {DTITLE => $dtitle, DBODY => $dbody};
      } else {
	last if /^-+$/;
	s/\n/<br \/>/;
	$dlists[-1]->{DBODY} .= $_;
      }
    }

    push @titles, {TITLE => $title, DLIST => \@dlists};
    push @indexes, {INDEX => $title};
  }
}

$template->param(HEAD => \@indexes);
$template->param(ARTICLE => \@titles);

print $template->output;


