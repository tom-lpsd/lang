#!/usr/bin/env ruby
hoge = 10
hoge.times do
  puts "Hello"
end
hoge2 = "hello2"
puts hoge2 + " hoge!!"

def Test(name)
  if name.length < 4
    name += " desu."
  else
    name += " DESU."
  end
end

Test("HO!")
