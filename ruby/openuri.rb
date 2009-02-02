#!/usr/bin/env ruby
require 'open-uri'

puts open('http://tom-lpsd.dyndns.org/tom/', "rb",
          "User-Agent" => "ruby/#{RUBY_VERSION} (+http://sp.ice.uec.ac.jp/~tom/)",
         "From" => "http://sp.ice.uec.ac.jp/~tom/")

