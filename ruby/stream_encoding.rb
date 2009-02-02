#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
File.open("euc-jp.txt", "a+:euc-jp:utf-8") do |f|
  f.each do |line|
    puts line if line =~ /あ.{4}/
  end
  f.print "さしすせそ"
end
