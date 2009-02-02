type figure =
    Point
  | Circle of int
  | Rectangle of int * int
  | Square of int

let area_of_figure = function
    Point -> 0
  | Circle r -> r * r * 3
  | Rectangle (x, y) -> x * y
  | Square x -> x * x

let similar x y =
  match (x, y) with
    (Point, Point) | (Circle _, Circle _) | (Square _, Square _) -> true
  | (Rectangle (l1, l2), Rectangle (l3, l4)) -> (l3 * l2 - l4 * l1) = 0
  | (Rectangle (v, h), Square _) -> v == h
  | (Square _, Rectangle (v, h)) -> v == h
  | _ -> false

type 'a with_location = {loc_x: float; loc_y: float; body: 'a}

let square x = x *. x

let distance x y = 
  sqrt ((square (x.loc_x -. y.loc_x)) +. (square (x.loc_y -. y.loc_y)))

let rec overlap 
    ({loc_x = x1; loc_y = y1; body = a} as obj1)
    ({loc_x = x2; loc_y = y2; body = b} as obj2) =
  match a with
    Circle r -> 
      (match b with
	Point -> false
      |	Circle r' -> (distance obj1 obj2) < float_of_int (r + r')
      |	Rectangle (x, y) -> 
	  let dx = (float_of_int x) /. 2.0 *. (if x1 < x2 then -1.0 else 1.0) and
	      dy = (float_of_int y) /. 2.0 *. (if y1 < y2 then -1.0 else 1.0) in
	  let dis = distance obj1 {obj2 with loc_x = x2 +. dx; loc_y = y2 +. dy} 
	  in dis < (float_of_int r)
      |	Square x -> overlap obj1 {obj2 with body = (Rectangle (x, x))})
  | Rectangle (x, y) -> 
      (match b with
	Point -> false
      |	Circle _ -> overlap obj2 obj1
      |	Rectangle (x', y') -> 
	  (if x1 < x2 then
	    x1 +. (float_of_int x) /. 2.0 > x2 -. (float_of_int x') /. 2.0
	  else
	    x1 -. (float_of_int x) /. 2.0 < x2 +. (float_of_int x') /. 2.0) &&
	  (if y1 < y2 then
	    y1 +. (float_of_int y) /. 2.0 > y2 -. (float_of_int y') /. 2.0
	  else
	    y1 -. (float_of_int y) /. 2.0 < y2 +. (float_of_int y') /. 2.0)
      |	Square x -> overlap obj1 {obj2 with body = (Rectangle (x, x))})
  | Square x ->
      (match b with
	Point -> false
      |	_ -> overlap obj2 {obj1 with body = (Rectangle (x, x))})
  | _ -> false;;

overlap {loc_x = 0.0; loc_y = 0.0; body = Circle 3} 
        {loc_x = 2.0; loc_y = 2.0; body = Rectangle (1, 1)};;
overlap {loc_x = 0.0; loc_y = 0.0; body = Rectangle (1, 1)} 
        {loc_x = 0.9; loc_y = 0.9; body = Rectangle (1, 1)};;
