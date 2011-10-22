require 'rubygems'
require 'sinatra'
require 'erb'
require '../lib/product'

require 'storage'
require 'catalogue'

set :static, true
set :root, '..'
set :public_folder, '../html'

set :views, settings.root + '/views'

def load_storage
  storage = Storage.new
  storage.load_products_file
  storage.load_quantity_file
  set :my_storage, storage
end

def load_catalogue storage
  catalogue = Catalogue.new
  storage.products.each do | product |
    catalogue.add_product product
  end

  set :my_catalogue, catalogue
end

configure do
  load_storage
  load_catalogue settings.my_storage
end

get '/' do
  redirect '/index.html'
end

get '/index.html' do

end

get '/product' do
  # This is needed for the test for now. Need to replace this with the actual object from the catalogue.
  @product = Product.new(5, "1234567890", "iPad", "Apple", "Very expensive product!", "Personal Gadgets", 500.00, "path_to_image", "GFA1")

  erb :product
end

post '/process' do
  text = params[:search_term]
  products = settings.my_catalogue.search(text)
  @array = products
  erb :productList
end



