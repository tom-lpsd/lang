MYLIBDIR = ../mylib
MYLIB = $(MYLIBDIR)/mylib.a
CFLAGS = -I$(MYLIBDIR)

all: s c

s: server.o sessionman.o
	$(CC) -o $@ $^

c: client.o session.o
	$(CC) -o $@ $^ $(MYLIB) -lcurses

server.o: mtalk2.h sessionman.h

client.o: mtalk2.h session.h

sessionman.o session.o: mtalk2.h

clean:
	$(RM) *.o s c *~
