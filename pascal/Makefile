BINDIR= ../bin/
vpath % $(BINDIR)
include ../common.mk

PC = fpc
PCFLAGS = -O3

% : %.pas
	$(PC) $< $(PCFLAGS)
	mv $@ $(BINDIR)
	$(RM) $@.o
