#!/usr/local/bin/ruby
require 'drb'
DRb.start_service()
obj = DRbObject.new(nil, 'druby://localhost:9000')
p obj.doit
