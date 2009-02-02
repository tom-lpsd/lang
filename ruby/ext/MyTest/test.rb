#!/usr/local/bin/ruby -I~/src/ruby/ext/MyTest
require "MyTest"
a = MyTest.new()
a.add(3)
a.add("hoge")
a.say()
Kernel.p(a)
