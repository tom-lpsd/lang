#!/usr/bin/env ruby

require 'net/https'

https = Net::HTTP.new('mixi.jp', 443)
https.use_ssl = true
https.verify_depth = 5
https.start { |w|
  response = w.get('/')
  puts response.body
}

req = Net::HTTP::Get.new('/')
p req
