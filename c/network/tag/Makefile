MYLIBDIR = ../mylib
MYLIB = $(MYLIBDIR)/mylib.a
CFLAGS = -I$(MYLIBDIR)

all: s c

s: server.o session.o
	$(CC) -o $@ $^ $(MYLIB) -lcurses

c: client.o session.o
	$(CC) -o $@ $^ $(MYLIB) -lcurses

server.o client.o: tag.h session.h

clean:
	$(RM) s c *.o *~
	
