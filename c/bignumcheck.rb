#!/usr/bin/env ruby
cnt = 0

1000.times do 
  x = rand(2**128)
  y = -rand(2**128)
  z = (x*y).to_s(16)
  ans = %x{../bin/bignum #{x} #{y}}.chomp
  if z != ans then
    puts "error #{x} #{y}\n#{z}\n#{ans}"
    cnt += 1
  end
end

if cnt then
  puts "#{cnt} errors in random test"
else
  puts "random test OK"
end

cnt = 0

10.times do |n|
  x = 2**(n*4)-1
  y = x
  z = (x*y).to_s(16)
  ans = %x{../bin/bignum #{x} #{y}}.chomp
  if z != ans then
    puts "error #{z} #{ans}"
    cnt += 1
  end
end

if cnt then
  puts "#{cnt} errors in normal"
else
  puts "random OK normal"
end
