#!/usr/bin/env ruby
require "xmlrpc/client"

# Make an object to represent the XML-RPC server.
server = XMLRPC::Client.new2( "http://b.hatena.ne.jp/xmlrpc")

url = "http://tom-lpsd.dyndns.org/tom/"
# Call the remote server and get our result
result = server.call("bookmark.getCount", url)

puts "Sum: #{result[url]}"
