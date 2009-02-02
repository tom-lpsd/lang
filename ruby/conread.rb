#!/usr/bin/env ruby
require 'benchmark'
require 'open-uri'

def conread(filenames)
  h = {}

  filenames.each do |filename|
    h[filename] = Thread.new do
      open(filename) { |f| f.read }
    end
  end

  h.each_pair do |filename, thread|
    begin
      h[filename] = thread.value
    rescue
      h[filename] = $!
    end
  end
end

Benchmark.bm do |t|
  files = %w{http://www.yahoo.co.jp/ http://mixi.jp/
             http://wikipedia.jp/
             http://sp.ice.uec.ac.jp/
             http://tom-lpsd.dyndns.org/tom/}
  t.report("conread") {
    conread(files)
  }
  t.report("normal read") {
    files.each {|file| open(file) {|f| f.read }}
  }
end

