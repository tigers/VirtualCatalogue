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
