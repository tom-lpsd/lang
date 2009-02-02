#!/usr/local/bin/ruby
require 'drb'

class TestServer
  def doit
    "Hello, Distributed World"
  end
end

aServerObject = TestServer.new
DRb.start_service('druby://localhost:9000',aServerObject)
DRb.thread.join
