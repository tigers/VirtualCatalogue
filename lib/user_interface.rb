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
  storage = Storage.load
  set :my_storage, storage
end

def load_catalogue storage
  catalogue = Catalogue.new
  storage.products.each do | product |
    begin
      catalogue.add_product product
    rescue
    end
  end

  set :my_catalogue, catalogue
end

def load_category
  category = Category.load
  set :my_category, category
end


configure do
  load_storage
  load_catalogue settings.my_storage
  load_category
end

get '/' do
  redirect '/search'
end

get '/admin' do

  @categories = settings.my_category.categories
  @array = []
  erb :admin
end

post '/admin' do
  @categories = settings.my_category.categories
  @selected_category = params[:category].to_i if params[:category] != nil
  @text = params[:search_term]
  products = settings.my_catalogue.search(@text, @selected_category)
  @array = products
  erb :admin
end

post '/productform' do
  @operation = params[:submitBtn]
  @search_term= params[:search_term]
  @category= params[:category]
  product_id = params[:product].to_i
  if @operation == 'Add'
    @product = Product.new(settings.my_catalogue.get_new_product_id,'','','','','','','','')
  else
    @product = settings.my_catalogue.get_product(product_id)
  end

  if @operation == 'Delete'
    settings.my_catalogue.remove_product(product_id)
    settings.my_storage.remove_product(product_id)
    settings.my_storage.save
    @operation = "Redirect"
  end

  erb :product_form
end

post '/productsave' do
  product = Product.new(params[:id].to_i,
                          params[:barcode],
                          params[:name],
                          params[:brand],
                          params[:description],
                          params[:category].to_i,
                          params[:price],
                          params[:picture],
                          params[:location] )
  if params[:operation] == "Add"
    settings.my_catalogue.add_product(product)
    settings.my_storage.add_product(product)
    settings.my_storage.save
  elsif params[:operation] == "Edit"
    settings.my_catalogue.edit_product(product)
    settings.my_storage.edit_product(product)
    settings.my_storage.save
  end
  @operation = "Redirect"
  erb :product_form
end


get '/search' do
  @categories = settings.my_category.categories
  erb :search
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
  @selected_category = 0

  @selected_category = params[:category].to_i if params[:category] != nil
  @text = params[:search_term]

  if @text == nil || @text == ""
   redirect '/search'
  end

  products = settings.my_catalogue.search(@text, @selected_category)
  @array = products

  @order = params[:order]

  if @order == nil
    @order = "pricelow"
  end

  if @order.start_with?("price")
    products.sort! {|a, b| a.price.to_i <=> b.price.to_i}
    if @order == "pricehigh"
        products.reverse!
    end
  elsif @order.start_with?("name")
    products.sort! {|a, b| a.name.capitalize <=> b.name.capitalize}
    if @order == "namehigh"
      products.reverse!
    end
  elsif @order.start_with?("brand")
    products.sort! {|a, b| a.brand.capitalize <=> b.brand.capitalize}
    if @order == "brandhigh"
      products.reverse!
    end
  end

  @array = products

  if @array.size == 0
    erb :noProduct
  else
    erb :productList
  end


end





