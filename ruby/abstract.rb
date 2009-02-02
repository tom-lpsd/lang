#!/usr/bin/ruby -Ku
require "rubygems"
require "postgres"
require "rexml/document"

htmls = Dir.glob("#{ENV['HOME']}/public_html/index.html")
conn = PGconn.connect("localhost",5432,"","","blog","tom","")

htmls.each do |name|
  year = "2005"

  file = File.new(name)
  doc = REXML::Document.new file

  doc.elements.each("//child::div[attribute::class=\"article\"]") do |element| 
    (day,title)=element.get_text(".//h4").value.split(/[\s　]+/)
    puts "#{day} #{title}"
    body = ""
    element.elements[".//div[attribute::class=\"art_body\"]"].each_element_with_text do |str|
      body += str.to_s.gsub(/<\/?p>/,'').gsub(/\n/,'').gsub(/<a href=["'](.*)['"]>(.*)<\/a>/,'[\1:title=\2]').gsub(/\t/,'') + "\n"
    end
    body.gsub!(/'/,"''")
    sql = %!insert into articles(title, body, date) values('#{title}','#{body}','#{year}/#{day}')!
    conn.exec(sql)
  end
end

