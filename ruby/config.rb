#!/usr/local/bin/ruby
require "rbconfig"
include Config
puts CONFIG["host"]
puts CONFIG["LDFLAGS"]
