#!/usr/bin/env ruby
require 'rubygems'
require 'icu4r'

str = "これはテストです．".to_u

str.each_char do |c|
  puts c
end

puts str.size
puts str[3]
