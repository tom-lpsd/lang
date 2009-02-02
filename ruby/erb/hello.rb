#!/usr/bin/env ruby
require 'erb'

html = <<EOF
<html>
<head>
<title>PageScores</title>
</head>
<body>
<ul>
<% urls.each do |url| -%>
<li><%= url %></li>
<% end -%>
</ul>
</body>
</html>
EOF

urls = %w|foo bar baz|
eb = ERB.new(html, nil, '-')
eb.run
