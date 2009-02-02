class Directory
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir[@path + '/*'].collect do |path|
      path.sub(@path + '/', "")
    end.sort
  end

  def compare(other)
    compfiles = (files - other.files).collect do |file|
      '- ' + file
    end +
    (other.files - files).collect do |file|
      '+ ' + file
    end
    same_name_files = files & other.files
    same_name_files.each do |file|
      fi = FileInfo.new(@path + "/" + file)
      other_fi = FileInfo.new(other.path + "/" + file)
      if !fi.compare(other_fi)
        compfiles.push sprintf("- %s %d", file, fi.size)
        compfiles.push sprintf("+ %s %d", file, other_fi.size)
      end
    end
    compfiles.sort do |file1, file2|
      ret = file1[2..-1].sub(/\s+\d+$/, "") <=> file2[2..-1].sub(/\s+\d+$/,"")
      if ret == 0
        ret = (/^\-/ =~ file1) ? -1 : 1
      end
      ret
    end
  end

end

class FileInfo

  def initialize(path)
    @path = path
  end

  def size
    File.size(@path)
  end

  def compare(other)
    size == other.size
  end

end
