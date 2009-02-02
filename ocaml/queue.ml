type 'a mlist = MNil | MCons of 'a * 'a mlist ref
type 'a queue = { mutable head : 'a mlist; mutable tail : 'a mlist }

let create () = { head = MNil; tail = MNil }

let add a = function
    {head = MNil; tail = MNil} as q ->
      let c = MCons (a, ref MNil) in
      q.head <- c; q.tail <- c
  | {tail = MCons (_, next)} as q ->
      let c = MCons (a, ref MNil) in
      next := c; q.tail <- c
  | _ -> failwith "enqueue: input queue broken"

let peek = function
    {head = MNil; tail = MNil} -> failwith "hd: queue is empty"
  | {head = MCons (a, _)} -> a
  | _ -> failwith "hd:queue is broken"

let take = function
    {head = MNil; tail = MNil} -> failwith "dequeue: queue is empty"
  | {head = MCons (a, next)} as q ->
	if !next = MNil then begin
	  q.head <- MNil;
	  q.tail <- MNil;
	  a
	end else begin
	  q.head <- !next; a
	end
  | _ -> failwith "dequeue: queue is broken"
