require 'rubygems'
require 'sinatra'
require 'erb'
require '../lib/product'

require 'storage'
require 'catalogue'
require 'category'

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

def load_category
  category = Category.new
  category.load_category_file
  set :my_category, category

end



configure do
  load_storage
  load_catalogue settings.my_storage
  load_category
 end

get '/' do
  redirect '/index.html'
end

get '/product/:id' do
  begin
    @product = settings.my_catalogue.get_product(params[:id].to_i)
  rescue ArgumentError
    halt 404, "Product does not exist."
  end

  erb :product
end

post '/process' do
  text = params[:search_term]
  products = settings.my_catalogue.search(text)
  @array = products
  erb :productList
end



