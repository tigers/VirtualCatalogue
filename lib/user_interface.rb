require 'rubygems'
require 'sinatra'
require 'erb'
require '../lib/product'


set :static, true
set :public_folder, '../html'

get '/' do
  redirect '/index.html'
end

get '/product' do

end

