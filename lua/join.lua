function join(list, del)
   local str = list[1]
   for idx = 2, table.getn(list) do
      str = str .. del .. list[idx]
   end
   return str
end
