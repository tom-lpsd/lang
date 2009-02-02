# Makefile for schedule
# $Id:$

package	          = schedule
package_version   = 0.0.0
kahua		  = kahua
SHELL             = /bin/sh
prefix            = /Users/tom/apps/kahua
exec_prefix       = ${prefix}
bindir            = ${exec_prefix}/bin
sbindir           = ${exec_prefix}/sbin
libexecdir	  = ${exec_prefix}/libexec
datarootdir	  = @datarootdir@
datadir		  = ${prefix}/share/$(kahua)
sysconfdir        = ${prefix}/etc/$(kahua)
sharedstatedir    = ${prefix}/com/$(kahua)
localstatedir     = ${prefix}/var/$(kahua)
libdir            = ${exec_prefix}/lib/$(kahua)
includedir        = ${prefix}/include/$(kahua)
oldincludedir     = /usr/include/$(kahua)
infodir           = ${prefix}/info
mandir            = ${prefix}/man
srcdir            = .

top_builddir      = 
top_srcdir        = .

DESTDIR  =

GOSH = /Users/tom/apps/bin/gosh
INSTALL = /usr/bin/install -c
KAHUA_INSTALL = /Users/tom/apps/kahua/bin/kahua-install
KAHUA_WORKING = $(localstatedir)
KAHUA_LIB     = $(libdir)
KAHUACONFIG =  -S /Users/tom/tmp/site

TEST_DIR    = $(PWD)

SCRIPTFILES = $(package)/$(package).kahua $(package)/version.kahua
STATICFILES = $(package)/$(package).css

SOURCEDIR   = $(package)
PLUGINDIR   = plugins
PLUGINFILES = $(package).scm

TEMPLATEDIR = templates
XMLFILES    = page.xml

ALL_TARGETS = $(package)/version.kahua test/test.scm test/test.conf
DIST_GENERATED = configure VERSION DIST_EXCLUDE_X
CONFIG_GENERATED = Makefile config.log config.status autom4*.cache
MAKE_GENERATED =  $(ALL_TARGETS) checkout
TEST_GENERATED = test/_tmp test/_work test/$(package)

.PHONY: all check clean distclean install maintainer-clean

all: $(ALL_TARGETS)

test/test.conf: test/test.conf.in
	sed -e "s@##TEST_DIR##@$(TEST_DIR)@" $? > $@
	test -L checkout || ln -s . checkout

test/test.scm:	test/test.scm.in
	sed -e "s@##GOSH##@$(GOSH)@" -e "s@##PLUGINS##@$(PLUGINFILES)@" \
	    -e "s@##KAHUA_WORKING##@$(KAHUA_WORKING)@" \
	    -e "s@##KAHUA_LIB##@$(KAHUA_LIB)@" \
	    -e "s@##PROJECT_VERSION##@$(package_version)@" \
	    $? > $@

$(package)/version.kahua: $(package)/version.kahua.in
	sed -e "s@##PROJECT_VERSION##@$(package_version)@" $? > $@

check:  all
	rm -f test/test.log
	cd test; $(GOSH) -I$(KAHUA_LIB) ./test.scm > test.log

clean:
	rm -rf core *~ $(package)/*~ test/*~ test/test.log $(TEST_GENERATED) $(MAKE_GENERATED)

install:
	for f in $(SCRIPTFILES); do \
	  $(KAHUA_INSTALL) $(KAHUACONFIG) -t script $$f;\
	done
	for f in $(STATICFILES); do \
	  $(KAHUA_INSTALL) $(KAHUACONFIG) -t static --no-overwrite $$f;\
	done
	for f in $(PLUGINFILES); do \
	  $(KAHUA_INSTALL) $(KAHUACONFIG) -t plugin -r $$f $(PLUGINDIR)/$$f;\
	done
	for f in $(XMLFILES); do \
	  $(KAHUA_INSTALL) $(KAHUACONFIG) -t template -r $(package)/$$f $(TEMPLATEDIR)/$$f;\
	done
	@cat MESSAGES

uninstall:
	$(KAHUA_INSTALL) -U $(KAHUACONFIG) -t static $(STATICFILES)
	$(KAHUA_INSTALL) -U $(KAHUACONFIG) -t plugin -r $(PLUGINFILE) \
                                        $(PLUGINDIR)/$(PLUGINFILE)

uninstall-scripts:
	$(KAHUA_INSTALL) -U $(KAHUACONFIG) -t script $(SCRIPTFILES)

distclean: clean
	-rm -rf $(CONFIG_GENERATED)

maintainer-clean: clean
	-rm -rf $(CONFIG_GENERATED) $(DIST_GENERATED)
