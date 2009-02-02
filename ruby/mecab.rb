#!/usr/bin/env ruby
require 'MeCab'
require 'kconv'
m = MeCab::Tagger.new
puts (m.parse("今日もももももももものうち".toeuc)).toutf8
