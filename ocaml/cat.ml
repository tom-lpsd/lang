open Arg

let print_file print_nump file =
  if print_nump 
  then
    let num = ref 1 in
    try 
      while true do
	Printf.printf "%6d\t%s\n" !num (input_line file);
	num := !num + 1
      done
    with
    | End_of_file -> ()
  else try 
    while true do
      print_endline (input_line file);
    done
  with
  | End_of_file ->()

let display_linenum = ref false
let filenames = ref []

let spec = [("-n", Set display_linenum, "Display line number.")]

let _ = 
  Arg.parse spec (fun s -> filenames := s :: !filenames)
    "Usage: cat [-n] [-help] filename ...";
  if List.length !filenames = 0 then
    print_file !display_linenum stdin
  else
    List.iter (fun filename -> 
      let file = open_in filename in
      print_file !display_linenum file;
      close_in file) 
      (List.rev !filenames)
