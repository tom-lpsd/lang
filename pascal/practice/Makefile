PC = fpc
BINDIR = ../../bin
PCFLAGS = -O3
VPATH = ../:../bin

.SUFFIXES: .o .pas
.PHONY : clean all

all: 
clean:
	$(RM) *.o

% : %.pas
	$(PC) $< $(PCFLAGS)
	mv $@ $(BINDIR)/
	$(RM) $@.o
