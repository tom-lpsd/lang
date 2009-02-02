#!/usr/local/bin/ruby
require 'marshal'

File.open("posterity") do |f|
  chord = Marshal.load(f)
  puts chord.play
end
