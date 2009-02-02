#!/usr/local/bin/ruby
a = [1,2,3,4,5,"a"]
b = [4,5,6,"bb"]
c = { "a" => "aa", "b" => "bb"}
puts a|b, c["a"], c.class, c.object_id
