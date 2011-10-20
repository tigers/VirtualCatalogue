require 'rubygems'
require 'sinatra'
require 'erb'
require 'storage'
require 'catalogue'

set :static, true
set :public_folder, '../html'

configure do
  storage = Storage.new
  set :my_storage, storage

  catalogue = Catalogue.new
  set :my_catalogue, catalogue

end

get '/' do
  redirect '/index.html'
end

