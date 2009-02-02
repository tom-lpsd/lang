let f = ref (fun y -> y + 1)
let funny_fact x = if x = 1 then 1 else x * (!f (x - 1));;
f := funny_fact
