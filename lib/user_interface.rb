require 'rubygems'
require 'sinatra'
require 'erb'
require '../lib/product'
#require '/home/MSC11/howarthg/VirtualCatalogue/views/product.erb'


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

get '/product' do
 @product = Product.new(5, "1234567890", "iPad", "Apple", "", "", 500.00, "", "")
 erb :product

end

