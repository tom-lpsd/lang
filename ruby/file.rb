#!/usr/local/bin/ruby
f = File.open("hoge")
f.each do |line|
  print line
end
f.close
