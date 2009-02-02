MYLIBDIR = ../mylib
MYLIB = $(MYLIBDIR)/mylib.a
CFLAGS = -I$(MYLIBDIR)
objs = bb0d.o bb1d.o bb9d.o bbreader.o bb9reader.o service.o session.o
daemons = bb0d bb1d bb9d
clients = bbreader bb9reader

all: $(daemons) $(clients)

bb0d: bb0d.o service.o
	$(CC) -o $@ $^

bb1d: bb1d.o service.o
	$(CC) -o $@ $^

bb9d: bb9d.o service.o
	$(CC) -o $@ $^

bbreader: bbreader.o session.o
	$(CC) -o $@ $^ $(MYLIB)

bb9reader: bb9reader.o session.o
	$(CC) -o $@ $^ $(MYLIB)

$(objs): bb.h

clean:
	$(RM) $(daemons) $(clients) $(objs) *~

ver0: bb0d bbreader

ver1: bb1d bbreader

ver9: bb9d bbreader

