class calc =
  object
    val mutable num = 0
    val mutable func = fun x -> x

    method input n = num <- n
    method plus = let x = num in func <- (fun y -> x + y)
    method eq = func num
    initializer 
      print_endline "calc"
  end

class calc_high =
  object
    inherit calc
    val mutable num = 10
    method eq = func num
    initializer
      print_endline "calc_high"
  end

let c = new calc_high

