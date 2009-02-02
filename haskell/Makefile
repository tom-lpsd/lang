HC=ghc
BINDIR= ../bin/

% : %.hs
	$(HC) $< -o $(BINDIR)$@
	$(RM) $@.hi
	$(RM) $@.o

include ../common.mk
