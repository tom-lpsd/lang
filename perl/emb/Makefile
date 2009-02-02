all: ex ex2 ex3
	
ex: xsinit.o ex.o
	gcc -o $@ $^ `perl -MExtUtils::Embed -e ldopts`
	
ex2: ex2.o ezembed.o
	gcc -o $@ $^ `perl -MExtUtils::Embed -e ldopts`

ex3: ex3.c
	gcc -o ex3 ex3.c `perl -MExtUtils::Embed -e 'ccopts ldopts'`

%.o : %.c
	gcc -c $^ `perl -MExtUtils::Embed -e ccopts`

