require 'runit/testcase'
require 'runit/cui/testrunner'

class TestString < RUNIT::TestCase
  def setup
    @str = String.new("RubyUnit is ")
  end

  def test_concat
    @str.concat("a Testing Framework")
    assert_equal("RubyUnit is a Testing Framework", @str)
  end

  def test_index
    assert_equal(0, @str.index("Ru"))
    assert_equal(4, @str.index("Unit"))
    assert_equal(6, @str.index("i"))

    assert_nil(@str.index("Peridot"))
  end
end

RUNIT::CUI::TestRunner.run(TestString.new("test_concat"))
