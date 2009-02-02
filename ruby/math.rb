#!/usr/local/bin/ruby
print "(t)imes or (p)lus: "
times = gets
print "number: "
number = gets.to_i
if times =~ /^t/
  calc = proc { |n| n*number }
else
  calc = proc { |n| n+number }
end

puts ((1..10).collect(&calc).join(", "))
