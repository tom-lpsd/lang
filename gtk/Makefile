BINDIR= ../bin/
include_dirs:=  ./include
CPPFLAGS+= $(addprefix -I,$(include_dirs)) `gtk-config --cflags`
LDLIBS= `gtk-config --libs` -lm
vpath % $(BINDIR)
vpath %.h $(include_dirs)

depends_imlib = imageviewer imlibtest
$(depends_imlib) : CPPFLAGS += `imlib-config --cflags-gdk`
$(depends_imlib) : LDLIBS += `imlib-config --libs-gdk`

include ../common.mk