require 'spec_helper'
require '../lib/catalogue'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    [200, 302].should include(last_response.status)
  end

  it "should respond to / and redirect to /search" do
    get '/'
    last_response.status.should == 302
    last_response.headers.should include 'Location'
    last_response.headers['Location'].should include 'search'
  end

  it "should respond to /search" do
    get '/search'
    last_response.should be_ok
  end

  it "should respond to /product with a not found an error" do
    get '/product'
    last_response.status.should == 404
  end

  context "application starts" do
    it "should load the storage object when it starts" do
      app.settings.my_storage.should_not be_nil
    end

    it "should load the catalogue object when it starts" do
      app.settings.my_catalogue.should_not be_nil
    end

    it "the catalogue should have the same products of the storage when the app starts" do
      app.settings.my_storage.should have(app.settings.my_catalogue.products.size).products
    end
  end

  context "display the data associated with the product" do
    before :all do
      c = Catalogue.new
      c.add_product Product.new(5, 1234567890, "iPad", "Apple", "Very expensive product!", "Personal Gadgets", 500.00, "ipad.jpg", "GFA1")
      app.settings.my_catalogue = c

      get '/product/5'
    end

    it {last_response.body.should include '5'}
    it {last_response.body.should include '1234567890'}
    it {last_response.body.should include 'iPad'}
    it {last_response.body.should include 'Apple'}
    it {last_response.body.should include 'Very expensive product!'}
    it {last_response.body.should include 'Personal Gadgets'}
    it {last_response.body.should include '500.00'}
    it {last_response.body.should include 'ipad.jpg'}
    it {last_response.body.should include 'GFA1'}

    it "should return a 404 error if the product does not exist" do
      get '/product/-1'
      last_response.status.should == 404
    end
  end

  context "Searching for products" do
    before :all do
      c = Catalogue.new
      c.add_product Product.new(1, 12345678,   "lcd tv1","sony", "lcd tv",                  "TV",               2000,   "1.jpg","level2")
      c.add_product Product.new(2, 23424678,   "lcd tv2","panasonic", "lcd tv",                  "TV",               1000,   "2.jpg","level2")
      c.add_product Product.new(5, 1234567890, "iPad", "Apple", "Very expensive product!", "Personal Gadgets", 500.00, "ipad.jpg", "GFA1")
      app.settings.my_catalogue = c
    end

    it "should respond to /process" do
      post '/process'
      last_response.should be_ok
    end

    it "should respond to /process, receive a search_term and return an array of products matching the term" do
      post '/process', 'search_term' => 'lcd'
      last_response.should be_ok
      last_response.body.should include('sony')
    end

    it "should respond to /process, receive a search_term that doesnt exist and return nothing" do
      post '/process', 'search_term' => 'product_doesnt_exist'
      last_response.should be_ok
      last_response.body.should_not include('ID')
    end
  end

  context "Sorting product list" do
    it "it should sort the products by price from low to high" do
      post '/process', 'search_term' => 'lcd', 'order' => 'pricelow'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should > last_response.body.index('lcd tv2')
    end

    it "it should sort the products by price from high to low" do
      post '/process', 'search_term' => 'lcd', 'order' => 'pricehigh'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should < last_response.body.index('lcd tv2')
    end
     it "it should sort the products by name from A to Z" do
      post '/process', 'search_term' => 'lcd', 'order' => 'namelow'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should < last_response.body.index('lcd tv2')
    end

    it "it should sort the products by name from Z to A" do
      post '/process', 'search_term' => 'lcd', 'order' => 'namehigh'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should > last_response.body.index('lcd tv2')
    end
     it "it should sort the products by brand from A to Z" do
      post '/process', 'search_term' => 'lcd', 'order' => 'brandlow'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should > last_response.body.index('lcd tv2')
    end

    it "it should sort the products by brand from Z to A" do
      post '/process', 'search_term' => 'lcd', 'order' => 'brandhigh'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should < last_response.body.index('lcd tv2')
    end

  end

  it "should include all of the categories available" do
    get '/search'
    app.settings.my_category.category.values.each do
      |value|
      last_response.body.should include(value)
    end
  end
end
