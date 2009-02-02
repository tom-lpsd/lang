-- hello.e
class HELLO
create
	make
feature
	make is
		do
			io.put_string("Hello World!!")
			io.put_new_line
		end
end
