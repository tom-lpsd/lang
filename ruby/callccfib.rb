#!/usr/bin/env ruby
continue = suspend = nil

resume = proc {|val|
   callcc {|cont| continue = cont; suspend.call(val)}
}

fib_gen = proc {|inia,inib| 
   a,b = inia,inib; loop {resume.call(a); a,b = b,a+b}
}

next_val = proc {
   callcc {|sus|
      suspend = sus
      unless continue; fib_gen.call(1,1) end
      continue.call
   }
}

20.times {puts next_val.call}
