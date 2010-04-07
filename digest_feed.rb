require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

video_ids = []
rss = nil
open('http://www.reddit.com/r/dubstep.rss') { |s| rss = RSS::Parser.parse(s.read, false) }

rss.items.each { |item| 
  if item.description =~ /http:\/\/www.youtube.com\/watch\?v=(.*)/
    video_id = $1[0..10]
    name = item.title
    comments_url = item.link
    user = $1 if item.description =~ /\<a href=\"http:\/\/www\.reddit\.com\/user\/([A-Za-z0-9_]*)\"\>/
    puts "NAME: #{name}"
    puts "VIDEO ID: #{video_id}"
    puts "COMMENTS URL: #{comments_url}"
    puts "USER: #{user}"
    puts "\n\n"
  end
}


# puts "Root values"
# print "RSS title: ", rss.channel.title, "\n"
# print "RSS link: ", rss.channel.link, "\n"
# print "RSS description: ", rss.channel.description, "\n"
# print "RSS publication date: ", rss.channel.date, "\n"
# 
# puts "Item values"
# print "number of items: ", rss.items.size, "\n"
# print "title of first item: ", rss.items[0].title, "\n"
# print "link of first item: ", rss.items[0].link, "\n"
# print "description of first item: ", rss.items[0].description, "\n"
# print "date of first item: ", rss.items[0].date, "\n"
