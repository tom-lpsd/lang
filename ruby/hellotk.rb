#!/usr/bin/env ruby 
require 'tk'
root = TkRoot.new { title "Ex1" }
TkLabel.new(root) {
  text "Hello, World!"
  pack('padx'=>30, 'pady'=>30, 'side'=>'left')
}
mycheck = TkVariable.new

TkCheckButton.new(root) {
  variable mycheck
  pack('padx'=>5, 'pady'=>5, 'side'=>'left')
}

TkButton.new(root) {
  text "OK"
  command proc { p mycheck.value; exit }
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)
}

lbl = TkLabel.new(root) {
  justify 'center'
  text 'Hello World2!'
  pack('padx'=>5, 'pady'=>5, 'side'=>'top')
}

TkButton.new(root) {
  text "Cancel"
  command proc { lbl.configure('text'=>"Goodbye, Cruel World!") }
  pack('side'=>'right', 'padx'=>10, 'pady'=>10)
}

Tk.mainloop
