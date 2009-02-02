#!/usr/bin/env ruby
require 'rubygems'
require 'scrapi'
require 'uri'

$KCODE = 'u'

scrapper = Scraper.define do
  process 'a[class=bookmark]', :title => :text, :url => '@href'
  process 'div[class=entry-footer] a:last-child', :link => '@href'
  result :title, :url, :link
end

scrappers = Scraper.define do
  array :bookmarks
  process 'div[class=entry]', :bookmarks => scrapper
  result :bookmarks
end

userscrapper = Scraper.define do
  process 'li > a:nth-child(3)', :user => :text
  result :user
end

userscrappers = Scraper.define do
  array :users
  process 'ul#bookmarked_user > li', :users => userscrapper
  result :users
end

scrappers.scrape(URI('http://b.hatena.ne.jp/'), 
                 :parser_options => {:char_encoding=>'utf8'}).each do |e|
  if e.link =~ /^\/entry/
    userscrappers.scrape(URI("http://b.hatena.ne.jp#{e.link}"),
                         :parser_options => {:char_encoding => 'utf8'}).each do |u|
      puts u
    end
    sleep 5
  end
end
