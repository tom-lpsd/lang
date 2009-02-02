#!/usr/local/bin/ruby
class Array
  def sum
    inject(0) { |n,value| n + value }
  end
  def product
    inject(1) { |n,value| n * value }
  end
end

puts [1,2,3,4,5,6,7,8,9,10].sum
puts [1,2,3,4,5,6,7,8,9,10].product
