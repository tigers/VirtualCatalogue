require 'spec_helper'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    [200, 302].should include(last_response.status)
  end

  it "should respond to / and redirect to /index.html" do
    get '/'
    last_response.status.should == 302
    last_response.headers.should include 'Location'
    last_response.headers['Location'].should include 'index.html'
  end

  it "should respond to /index.html" do
    get '/index.html'
    last_response.should be_ok
  end

  it "should respond to /product" do
    get '/product'
    last_response.should be_ok
  end

  it "should display the data associated with the product" do
    get '/product', :product => Product.new(5, "1234567890", "iPad", "Apple", "Very expensive product!", "Personal Gadgets", 500.00, "directory_to_image", "GFA1")
    last_response.body.should include '5' and '1234567890' and 'iPad' and 'Apple' and 'Very expensive product!' and 'Personal Gadgets' and '500.00' and 'directory_to_image' and 'GFA1'
  end

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
