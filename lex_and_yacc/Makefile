CC=gcc
LDLIBS=-lfl

% : %.y %.l
	flex $*.l
	bison -d $*.y
	mv -f $*.tab.c $*.c
	gcc -c $*.c lex.yy.c
	gcc -o $@ $*.tab.o lex.yy.o -lfl
	rm -f $*.tab.* lex.yy.[co]
