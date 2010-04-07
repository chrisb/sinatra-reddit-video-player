require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'sequel'
require 'json'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

get '/stylesheets/dubbit.css' do
  sass :dubbit
end

get '/' do
  @db = Sequel.sqlite('db/dubbit.sqlite3')
  haml :index
end