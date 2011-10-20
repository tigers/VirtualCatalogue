require 'rubygems'
require 'sinatra'
require 'erb'
require 'storage'
require 'catalogue'

set :static, true
set :public_folder, '../html'

configure do
  storage = Storage.new
  storage.load_products_file
  storage.load_quantity_file
  set :my_storage, storage

  catalogue = Catalogue.new
  storage.products.each do | product |
    catalogue.add_product product
  end

  set :my_catalogue, catalogue

end

get '/' do
  redirect '/index.html'
end

