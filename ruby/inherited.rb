#!/usr/bin/env ruby

def Object.inherited(c)
  puts "class #{c} < #{self}"
end

class A; end
