#!/usr/local/bin/ruby
def threeTimes
  yield
  yield
  yield
end
threeTimes { puts "Hello" }

def fibUpTo(max)
  i1, i2 = 1,1
  while i1 <= max
    yield i1
    i1,i2 = i2, i1+i2
  end
end
fibUpTo(1000) { |f| print f, " " }
puts

[1,2,3,4].collect {|x| x*x} .each {|x| print x, " "}
puts
