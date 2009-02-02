OBJS = setup_client.o setup_server.o chop_newline.o setup_mserver.o
AR = ar -qc

mylib.a: $(OBJS)
	$(RM) $@
	$(AR) $@ $(OBJS)


$(OBJS): mylib.h

clean:
	$(RM) *.o mylib.a

OBJS6 = setup_client6.o setup_server6.o chop_newline.o setup_mserver6.o

mylib6.a: $(OBJS6)
	$(RM) $@
	$(AR) $@ $(OBJS6)

$(OBJS6): mylib.h
