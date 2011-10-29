require 'spec_helper'
require '../lib/catalogue'

describe "Admin Interface" do
  include Rack::Test::Methods

  it "should respond to /admin" do
    get '/admin'
    last_response.should be_ok
  end

  it "should respond to post /productform" do
    post '/productform'
    last_response.should be_ok
  end

  it "should respond to /productform when 'add' button is pressed" do
    post '/productform', :submitBtn => "Add"
    last_response.should be_ok
    last_response.body.should include "Add Product"
    ["name", "barcode", "brand", "description", "price", "picture", "location"].each do | att |
      last_response.body.should include "<input type=\"text\" name=\"#{att}\" value=\"\"/>"
    end

  end

end
