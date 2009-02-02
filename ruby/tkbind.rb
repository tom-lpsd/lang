#!/usr/bin/env ruby
require 'tk'

root = TkRoot.new { title 'bind sample' }
image1 = TkPhotoImage.new { file ARGV[0] }
image2 = TkPhotoImage.new { file ARGV[1] }

b = TkButton.new(root) {
  image image1
  command proc { exit }
}

b.bind("Enter") { b.configure('image'=>image2) }
b.bind("Leave") { b.configure('image'=>image1) }
b.pack('padx'=>10, 'pady'=>10, 'side'=>'left')

Tk.mainloop
