require 'runit/testcase'
require 'runit/cui/testrunner'
require 'managefile'
require 'cmpdir'

class TestDirectory < RUNIT::TestCase
  include ManageFile

  def test_s_new
    directory = Directory.new("Foo")
    assert_instance_of(Directory, directory)
  end

  def test_files
    Dir.mkdir("testdir")
    create_file("testdir/file1")
    begin
      directory = Directory.new("testdir")
      assert_equal(['file1'], directory.files)
    ensure
      File.delete("testdir/file1")
      Dir.rmdir("testdir")
    end

    Dir.mkdir("empty_dir")
    begin
      directory = Directory.new("empty_dir")
      assert_equal([], directory.files)
    ensure
      Dir.rmdir("empty_dir")
    end

    Dir.mkdir("dir_somefiles")
    create_file("dir_somefiles/file_b")
    create_file("dir_somefiles/file_a")
    create_file("dir_somefiles/file_c")
    begin
      directory = Directory.new("dir_somefiles")
      assert_equal(['file_a', 'file_b', 'file_c'],
                   directory.files)
    ensure
      File.delete("dir_somefiles/file_b")
      File.delete("dir_somefiles/file_a")
      File.delete("dir_somefiles/file_c")
      Dir.rmdir("dir_somefiles")
    end

  end

  def test_compare

    create_test_dir("test1", "file_a", "file_b")
    create_test_dir("test2")
    begin
      dir1 = Directory.new("test1")
      dir2 = Directory.new("test2")
      assert_equal(['- file_a', '- file_b'],
                   dir1.compare(dir2))
    ensure
      remove_test_dir("test1", "file_a", "file_b")
      remove_test_dir("test2")
    end

    create_test_dir("test1", "file_a", "file_b")
    create_test_dir("test2", "file_a", "file_b")
    begin
      dir1 = Directory.new("test1")
      dir2 = Directory.new("test2")
      assert_equal([], dir1.compare(dir2))
    ensure
      remove_test_dir("test1", "file_a", "file_b")
      remove_test_dir("test2", "file_a", "file_b")
    end

    create_test_dir("test1", "file_a")
    create_test_dir("test2", "file_a", "file_b")
    begin
      dir1 = Directory.new("test1")
      dir2 = Directory.new("test2")
      assert_equal(['+ file_b'], dir1.compare(dir2))
    ensure
      remove_test_dir("test1", "file_a")
      remove_test_dir("test2", "file_a", "file_b")
    end

    create_test_dir("test1", "file_a", "file_b", "file_c", "file_e")
    create_test_dir("test2", "file_a", "file_c", "file_d")
    begin
      dir1 = Directory.new("test1")
      dir2 = Directory.new("test2")
      assert_equal(['- file_b', '+ file_d', '- file_e'],
                   dir1.compare(dir2))
    ensure
      remove_test_dir("test1", "file_a", "file_b", "file_c", "file_e")
      remove_test_dir("test2", "file_a", "file_c", "file_d")
    end

  end

  def test_compare_size
    Dir.mkdir("test1")
    Dir.mkdir("test2")
    create_file("test1/file_a", 5)
    create_file("test2/file_a", 10)
    begin
      dir1 = Directory.new("test1")
      dir2 = Directory.new("test2")
      assert_equal(['- file_a 5', '+ file_a 10'],
                   dir1.compare(dir2))
    ensure
      remove_test_dir("test1", "file_a")
      remove_test_dir("test2", "file_a")
    end
  end

  def create_test_dir(testdir, *files)
    Dir.mkdir(testdir)
    files.each do |file|
      create_file(testdir + "/" + file)
    end
  end
  
  def remove_test_dir(testdir, *files)
    files.each do |file|
      File.delete(testdir + "/" + file)
    end
    Dir.rmdir(testdir)
  end

end

if $0 == __FILE__
  if ARGV.size == 0
    suite = TestDirectory.suite
  else
    suite = RUNIT::TestSuite.new
    ARGV.each do |testmethod|
      suite.add_test(TestDirectory.new(testmethod))
    end
  end
  RUNIT::CUI::TestRunner.run(suite)
end
