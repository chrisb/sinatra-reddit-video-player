require 'rubygems'
require 'sinatra'

require 'dubbit'

run Sinatra::Application

log = File.new("sinatra.log", "a+")

$stdout.reopen(log)