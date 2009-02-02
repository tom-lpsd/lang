c1=coroutine.create(function() while true do print("coroutine 1"); coroutine.yield(); end end)
c2=coroutine.create(function() while true do print("coroutine 2"); coroutine.yield(); end end)
while coroutine.resume(c1) and coroutine.resume(c2) do end
