#!/usr/local/bin/ruby
aFile = File.new("hoge")
aFile.each_byte {|ch| putc ch; putc ?.}
aFile.close

aFile = File.new("hoge")
aFile.each_line {|line| puts "Got #{line.dump}"}
aFile.close

IO.foreach("hoge") {|line| puts line}
