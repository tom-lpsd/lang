#!/usr/local/bin/ruby
require 'marshal'

c = Chord.new( [Note.new("G"), Note.new("Bb"),
                Note.new("Db"),Note.new("E") ] )

File.open("posterity","w+") do |f|
  Marshal.dump(c,f)
end
