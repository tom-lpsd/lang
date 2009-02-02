open Tk
open Printf

let balance = ref 0
let add_balance x = balance := !balance + x

let top = openTk ();;
Wm.title_set top "Bank Emulation";;

let tv_balance = Textvariable.create ()
let label1 = Label.create top ~textvariable:tv_balance ~relief:`Raised

let print_balance tv =
  if !balance < 0 then (closeTk (); exit 0)
  else
    let s = sprintf "残高は %8d 円です" !balance in
    Textvariable.set tv s

let bot_frame = Frame.create top
let entry = Entry.create bot_frame
and label2 = Label.create bot_frame ~text:"円"
and rb_frame = Frame.create bot_frame

let tv_button = Textvariable.create ()

let radiobuttons = 
  List.map
    (fun (t, a) -> 
      Radiobutton.create rb_frame ~text:t ~value:a ~variable:tv_button)
    [("を預金する", "Deposit"); ("を引き出す", "Withdraw")]

let action entry tv_but tv_bal () =
  let y = int_of_string (Entry.get entry) in
  match Textvariable.get tv_but with
    "Deposit" -> add_balance y; print_balance tv_bal
  | "Withdraw" -> add_balance (-y); print_balance tv_bal
  | _ -> failwith "Cannot happend"

let button = Button.create bot_frame 
    ~text:"OK!" 
    ~command:(action entry tv_button tv_balance)

let menu = Menu.create top
let submenu = Menu.create menu

let () =
  Menu.add_command ~label:"Press Me!"
    ~command:(fun () -> print_string "Hello!"; print_newline ()) menu;
  Menu.add_cascade ~label:"Cascade" ~menu:submenu menu;
  Menu.add_command ~label:"Don't Press Me!"
    ~command:(fun () -> closeTk (); exit 0) submenu;
  Menu.add_separator submenu;
  Menu.add_checkbutton ~label:"Check" submenu;
  Toplevel.configure ~menu:menu top

let () =
  pack radiobuttons ~side:`Top;
  pack [coe entry; coe label2; coe rb_frame; coe button] ~side:`Left;
  pack [coe label1; coe bot_frame] ~side:`Top;
  print_balance tv_balance;
  mainLoop ();

