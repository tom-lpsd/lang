#!/usr/bin/env ruby
require 'rubygems'
require 'activerecord'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :host     => "localhost",
  :username => "tom",
  :password => "",
  :database => "arsample"
  )

class Mytest < ActiveRecord::Base
end

=begin
test = Mytest.new(:name => 'tom')
test.save
=end

one = Mytest.find(1)
puts one.name
puts one.methods
