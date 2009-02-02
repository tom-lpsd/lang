#!/usr/bin/env ruby
require 'rubygems'
require 'postgres'

conn = PGconn.connect("localhost",5432,"","","blog","tom","")
res = conn.exec("select * from articles")

#sql = %{insert into articles(title, body) values('hoge','bogebody')}
#conn.exec(sql)
