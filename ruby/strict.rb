#!/usr/bin/env ruby
module Strict
  def singleton_method_added(name)
    STDERR.puts "Warning: singleton #{name} added to a Strict object"
    eigenclass = class << self; self; end
    eigenclass.class_eval { remove_method name }
  end
end

class A
  include Strict
  def A.singleton_method_added(name)
    p name
  end
end

a = A.new

def a.foo; end

