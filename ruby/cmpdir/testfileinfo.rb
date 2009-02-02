require 'runit/testcase'
require 'runit/cui/testrunner'
require 'managefile'
require 'cmpdir'

class TestFileInfo < RUNIT::TestCase
  include ManageFile

  def check_size(size)
    create_file("testfile", size)
    begin
      fileinfo = FileInfo.new("testfile")
      assert_equal(size, fileinfo.size)
    ensure
      File.delete("testfile")
    end    
  end

  def check_compare(size1, size2)
    create_file("file1", size1)
    create_file("file2", size2)
    begin
      fileinfo1 = FileInfo.new("file1")
      fileinfo2 = FileInfo.new("file2")
      expected = (size1 == size2)
      assert_equal(expected, fileinfo1.compare(fileinfo2))
    ensure
      File.delete("file1", "file2")
    end
  end
  
  def test_s_new
    fileinfo = FileInfo.new("file")
    assert_instance_of(FileInfo, fileinfo)
  end

  def test_size
    check_size(0)
    check_size(10)
  end

  def test_compare
    check_compare(10, 10)
    check_compare(10, 5)
  end

end

if $0 == __FILE__
  if ARGV.size == 0
    suite = TestFileInfo.suite
  else
    suite = RUNIT::TestSuite.new
    ARGV.each do |testmethod|
      suite.add_test(TestFileInfo.new(testmethod))
    end
  end
  RUNIT::CUI::TestRunner.run(suite)
end

