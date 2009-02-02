OBJS=httpget.o
SRCS=$(OBJS:%.o=%.c)

CFLAGS=-g -DX86

LDLIBS=

TARGET=httpget
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(TARGET) $(OBJS) $(LDLIBS)
