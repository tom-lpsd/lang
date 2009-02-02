module ManageFile
  def create_file(filename, size=-1)
    ofs = open(filename, "w")
    if size < 0
      ofs.print "this is #{filename}"
    else
      size.times {
        ofs.print "X"
      }
    end
    ofs.close
  end
end
