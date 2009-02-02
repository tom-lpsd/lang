MYLIBDIR = ../mylib
MYLIB = $(MYLIBDIR)/mylib.a
OBJS1 = server.o sessionman.o
OBJS2 = client.o session.o
CFLAGS = -I$(MYLIBDIR)

all: s c

s: $(OBJS1)
	$(CC) -o $@ $^ $(MYLIB) -lcurses

c: $(OBJS2)
	$(CC) -o $@ $^ $(MYLIB) -lcurses

server.o : sessionman.h

client.o : session.h

clean:
	$(RM) s c $(OBJS1) $(OBJS2) *~

