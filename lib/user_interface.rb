require 'rubygems'
require 'sinatra'
require 'erb'
require 'storage'

set :static, true
set :public_folder, '../html'

configure do
  storage = Storage.new
  set :my_storage, storage
end

get '/' do
  redirect '/index.html'
end

