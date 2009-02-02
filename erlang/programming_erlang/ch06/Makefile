.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

.yrl.erl:
	erlc -W $<

ERL = erl -boot start_clean

MODS = hello

all: compile

compile: ${MODS:%=%.beam} subdirs

special1.beam: special1.erl
	${ERL} -Dflag1 -W0 special1.erl

application1: compile
	${ERL} -pa Dir1 -s application1 start Arg1 Arg2

hello: hello.beam
	${ERL} -s hello hello 10 -s init stop

subdirs:
#	cd dir1; make
#	cd dir2; make

clean:
	rm -rf *.beam erl_crash.dump
#	cd dir1; make clean
#	cd dir2; make clean
