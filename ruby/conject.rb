#!/usr/bin/env ruby
require 'benchmark'
require 'thread'

module Enumerable
  def conject(initial, mapper, injector)
    q = Queue.new

    count = 0
    each do |item|
      Thread.new do
        q.enq(mapper[item])
      end
      count += 1
    end

    t = Thread.new do
      x = initial
      while(count > 0)
        x = injector[x, q.deq]
        count -= 1
      end
      x
    end

    t.value
  end
end

a = (1..10000).to_a
mapper = lambda {|x| Math.sin(x)}
injector = lambda {|total,x| total+x}

Benchmark.bm do |t|
  t.report("concurrent") do
    b = a.conject(0, mapper, injector)
    puts b
  end
  t.report("normal") do
    b = a.inject(0) do |total, x|
      total + Math.sin(x)
    end
    puts b
  end
end
