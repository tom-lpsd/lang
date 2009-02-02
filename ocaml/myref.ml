type 'a myref = { mutable mycontents : 'a }
let myref x = { mycontents = x }
let (!%) { mycontents = x }  = x
let (%:=) x v = x.mycontents <- v
