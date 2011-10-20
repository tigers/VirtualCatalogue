require 'rubygems'
require 'sinatra'
require 'erb'

get '/' do
  redirect '/index.html'
end

