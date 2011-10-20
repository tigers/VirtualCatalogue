require 'rubygems'
require 'sinatra'
require 'erb'

set :static, true
set :public_folder, '../html'

get '/' do
  redirect '/index.html'
end

