#!/usr/bin/env ruby
require 'rubygems'
require 'postgres'

conn = PGconn.connect("localhost", 5432, "", "", "historydb", "tom", "")
conn.exec("begin").status
conn.exec("DECLARE tmp_cur CURSOR FOR SELECT DISTINCT usr FROM history20060602").status
while result = conn.query("FETCH tmp_cur")[0]
  break if result.nil?
  p result
end
conn.exec("commit").status
conn.close
