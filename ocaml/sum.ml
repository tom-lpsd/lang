type ('a, 'b) sum = Left of 'a | Right of 'b

let f1 (x, y) =
  match y with
    Left y' -> Left (x, y')
  | Right y' -> Right (x, y')

let f2 = function
    Left (x, y) -> (x, Left y)
  | Right (x, y) -> (x, Right y)

let f3 = function
    (Left x, Left y) -> Left (Left (x, y))
  | (Left x, Right y) -> Right (Left (x, y))
  | (Right x, Left y) -> Left (Right (x, y))
  | (Right x, Right y) -> Right (Right (x, y))
    
let f4 = function
    Left (Left (x, y)) -> (Left x, Left y)
  | Left (Right (x, y)) -> (Right x, Left y)
  | Right (Left (x, y)) -> (Left x, Right y)
  | Right (Right (x, y)) -> (Right x, Right y)

let f5 f g = function
    Left x -> f x
  | Right x -> g x

let f6 f =
  let left x = f (Left x) and
      right x = f (Right x)
  in (left, right)

let f7 f x = 
  match f with
    Left f -> Left (f x)
  | Right f -> Right (f x)
