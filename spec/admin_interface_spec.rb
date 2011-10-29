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

  it "should respond to /productform when 'edit' button is pressed" do
    c = Catalogue.new
      c.add_product Product.new(1, bc=12345678, n="lcd tv1", b="sony", d="lcd tv", cat=3, p=2000, pict="1.jpg", l="level2")
    app.settings.my_catalogue = c

    post '/productform', :submitBtn => "Edit", :product => "1"
    last_response.should be_ok
    last_response.body.should include "Edit Product"
    {"name" => n, "barcode"=>bc, "brand"=>b, "description"=>d, "price"=>p, "picture"=>pict, "location"=>l}.each_pair do | att, value |
      last_response.body.should include "<input type=\"text\" name=\"#{att}\" value=\"#{value}\"/>"
    end

  end

  it "should respond to /productform when 'delete' button is pressed" do
    c = Catalogue.new
      c.add_product Product.new(1, bc=12345678, n="lcd tv1", b="sony", d="lcd tv", cat=3, p=2000, pict="1.jpg", l="level2")
    app.settings.my_catalogue = c

    post '/productform', :submitBtn => "Delete", :product => "1"
    last_response.should be_ok

    lambda{
      app.settings.my_catalogue.get_product(1)
    }.should raise_error(ArgumentError)


  end

end
