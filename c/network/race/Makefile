MYLIBDIR = ../mylib
MYLIB = $(MYLIBDIR)/mylib.a
OBJS1 = server.o sessionman.o
OBJS2 = client.o session.o
CFLAGS = -I$(MYLIBDIR)

all: s c

s: $(OBJS1)
	$(CC) -o $@ $^ $(MYLIB)

c: $(OBJS2)
	$(CC) -o $@ $^ $(MYLIB) -lcurses

data_ed: data_ed.o
	$(CC) -o $@ $^ -lcurses

checker: checker.o
	$(CC) -o $@ @^

server.o: race.h sessionman.h

client.o: race.h session.h

data_ed.o checker.o session.o sessionman.o: race.h

clean:
	$(RM) $(OBJS1) $(OBJS2) s c data_ed checker *~
