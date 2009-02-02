require 'runit/testsuite'
require 'runit/cui/testrunner'

require 'testdirectory'
require 'testfileinfo'

suite = RUNIT::TestSuite.new
ObjectSpace.each_object(Class) do |c|
  if c.ancestors.include?(RUNIT::TestCase)
    suite.add_test(c.suite)
  end
end
RUNIT::CUI::TestRunner.run(suite)
