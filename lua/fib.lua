#!/usr/bin/env lua

function fib(n)
   if n <= 2 then
      return 1
   end
   local p, pp
   p = 1 pp = 1
   for i = 3, n do
      x = p + pp
      pp = p
      p = x
   end
   return x
end

print(fib(16)) -- perhaps 987
