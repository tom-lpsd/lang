BINDIR= ../bin/
include_dirs:=  ./include
CPPFLAGS+= $(addprefix -I,$(include_dirs))
vpath % $(BINDIR)
vpath %.h $(include_dirs)

depend_pthreads = simple_threads thread_test cvsimple

$(depend_pthreads) : LDLIBS += -lpthread

include ../common.mk
CFLAGS=-g -Wall