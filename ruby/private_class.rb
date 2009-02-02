#!/usr/bin/env ruby

class Foo
  private

  class Bar
    def initialize
      puts "bar"
    end
  end
  
  def foo
    puts "foo method"
  end

  public

  def initialize
    puts "foo"
  end
end

f = Foo.new
b = Foo::Bar.new
