require 'sequel'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

namespace :dubbit do
  desc 'Imports YouTube videos listed on /r/dubstep into the local database'
  task :update do
    db = Sequel.sqlite('db/dubbit.sqlite3')
    rss = nil
    open('http://www.reddit.com/r/dubstep.rss') { |s| rss = RSS::Parser.parse(s.read, false) }

    rss.items.each { |item| 
      if item.description =~ /http:\/\/www.youtube.com\/watch\?v=(.*)/
        video_id = $1[0..10]
        name = item.title
        comments_url = item.link
        user = $1 if item.description =~ /\<a href=\"http:\/\/www\.reddit\.com\/user\/([A-Za-z0-9_]*)\"\>/
        if db[:videos].filter(:video_id => video_id).first.nil?
          puts "Inserting record for: #{name} ..."
          db[:videos].insert( :name => name, :video_id => video_id, :comments_url => comments_url, :user => user )
        else
          puts "Skipping duplicate: #{name}"
        end
      end
    }
  end
end