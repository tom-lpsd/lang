#!/usr/bin/env ruby
require 'tk'

def busy
  begin
    $root.cursor "watch"
    $root.update
    yield
  ensure
    $root.cursor ""
    $root.update
  end
end

$root = TkRoot.new { title 'Scroll List' }
frame = TkFrame.new($root)

list_w = TkListbox.new(frame,'selectmode' => 'single')

scroll_bar = TkScrollbar.new(frame,
                             'command' => proc{|*args| list_w.yview *args})
scroll_bar.pack('side'=>'left', 'fill'=>'y')
list_w.yscrollcommand(proc {|first,last| scroll_bar.set(first,last)})
list_w.pack('side'=>'left')

image_w = TkPhotoImage.new
TkLabel.new(frame, 'image'=>image_w).pack('side'=>'left')
frame.pack

list_contents = Dir["/home/tom/blog/image/*.gif"]
list_contents.each { |x|
  list_w.insert('end',x)
}
list_w.bind("ButtonRelease-1") {
  index = list_w.curselection[0]
  busy {
    tmp_img = TkPhotoImage.new('file'=>list_contents[index])
    scale = tmp_img.height / 100
    scale = 1 if scale < 1
    image_w.copy(tmp_img,'subsample'=>[scale,scale])
    tmp_img = nil
    GC.start
  }
}

Tk.mainloop
