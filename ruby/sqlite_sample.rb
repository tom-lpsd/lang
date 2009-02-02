#!/usr/bin/env ruby
require 'rubygems'
require 'sqlite3'

db = SQLite3::Database.new("test.db")
db.execute("create table foo(id integer, url text, body text);")
db.execute("insert into foo values(100,'http://mixi.jp','<html></html>')")
db.close()

