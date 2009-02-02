let my_print_int i = output_string stdout (string_of_int i)

let display_file filename = 
  let file = open_in filename and 
      n = ref 1 in
  try
    while true do
      print_int !n;
      print_string (" " ^ (input_line file));
      print_newline ();
      n := !n + 1
    done
  with
    End_of_file -> close_in file

let cp name1 name2 =
  let infile = open_in name1 and
      outfile = open_out name2
  in try
    while true do
      output_string outfile (input_line infile);
      output_string outfile "\n"
    done
  with
    End_of_file -> 
      close_in infile;
      close_out outfile
