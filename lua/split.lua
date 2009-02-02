#!/usr/bin/env lua

function split(str)
   local list, check, n
   list = {}
   
   check = function(v)
	      table.insert(list, v)
	   end

   str, n = string.gsub(str, "(%S+)", check)
   if (n > 0) then
      return list
   end
end

line = "The quick brown fox jumps over the lazy dog"
words = split(line)

for idx = 1, table.getn(words) do
   print(words[idx])
end
