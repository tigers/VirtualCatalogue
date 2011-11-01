require 'spec_helper'
require '../lib/catalogue'

describe "Admin Interface" do
  include Rack::Test::Methods

  before :all do
    @catalogue = app.settings.my_catalogue
  end

  after :all do
    app.settings.my_catalogue = @catalogue
  end

  it "should respond to /admin" do
    get '/admin'
    last_response.should be_ok
  end

  it "should respond to post /productform" do
    post '/productform', :submitBtn => "Add"
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

  context "Saving a new product" do
    before :all do
      #c = Catalogue.new
      #app.settings.my_catalogue = c
      @id = settings.my_catalogue.get_new_product_id
      post '/productsave', :operation => "Add", :submitBtn => "Save", :id =>@id, :name =>  "lcd tv1", :barcode => "12345678", :brand => "sony", :category => "3", :description => "lcd tv", :price => "2000", :picture => "1.jpg", :location => "level2"
    end

    it "should respond to /productsave when 'Save' button is pressed" do
      last_response.should be_ok

      lambda{
        app.settings.my_catalogue.get_product(@id)
      }.should_not raise_error(ArgumentError)
    end

    it "should contain the same details saved in the product" do
      last_response.should be_ok

      product = app.settings.my_catalogue.get_product(@id)
      product.id.should == @id
      product.name.should == "lcd tv1"
      product.barcode.should == "12345678"
      product.brand.should == "sony"
      product.category_id.should == 3
      product.description.should == "lcd tv"
      product.price.should == "2000"
      product.picture.should == "1.jpg"
      product.location.should == "level2"
    end

  end

  context "Editing a product" do
    before :all do
      #c = Catalogue.new
      #c.add_product Product.new(@id=1, bc=12345678, n="lcd tv1", b="sony", d="lcd tv", cat=3, p=2000, pict="1.jpg", l="level2")
      #app.settings.my_catalogue = c
      @id = 1
      post '/productsave', :operation => "Edit",  :submitBtn => "Save", :id =>@id, :name =>  "lcd tv3", :barcode => "12345678", :brand => "sony", :category => "4", :description => "lcd tv", :price => "4000", :picture => "1.jpg", :location => "level2"
    end

    it "should respond to /productsave when 'Save' button is pressed" do
      last_response.should be_ok

      lambda{
        app.settings.my_catalogue.get_product(@id)
      }.should_not raise_error(ArgumentError)
    end

    it "should contain the same details saved in the product" do
      last_response.should be_ok

      product = app.settings.my_catalogue.get_product(@id)
      product.id.should == @id
      product.name.should == "lcd tv3"
      product.barcode.should == "12345678"
      product.brand.should == "sony"
      product.category_id.should == 4
      product.description.should == "lcd tv"
      product.price.should == "4000"
      product.picture.should == "1.jpg"
      product.location.should == "level2"
    end

  end

  context "Sorting product list" do
    before :all do
      c = Catalogue.new
      c.add_product Product.new(1, 12345678, "lcd tv1","sony", "lcd tv", 3, 2000, "1.jpg","level2")
      c.add_product Product.new(2, 23424678, "lcd tv2","panasonic", "lcd tv", 2, 1000, "2.jpg","level2")
      c.add_product Product.new(5, 1234567890, "iPad", "Apple", "Very expensive product!", 4, 500.00, "ipad.jpg", "GFA1")
      app.settings.my_catalogue = c
    end

    it "it should sort the products by id from low to high" do
      post '/admin', 'search_term' => 'lcd', 'category' => '0', 'order' => 'idlow'
      p last_response.body
      last_response.should be_ok
      last_response.body.index('lcd tv1').should < last_response.body.index('lcd tv2')
    end

    it "it should sort the products by id from high to low" do
      post '/admin', 'search_term' => 'lcd', 'category' => '0', 'order' => 'idhigh'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should > last_response.body.index('lcd tv2')
    end

    it "it should sort the products by name from A to Z" do
      post '/admin', 'search_term' => 'lcd', 'category' => '0', 'order' => 'namelow'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should < last_response.body.index('lcd tv2')
    end

    it "it should sort the products by name from Z to A" do
      post '/admin', 'search_term' => 'lcd', 'category' => '0', 'order' => 'namehigh'
      last_response.should be_ok
      last_response.body.index('lcd tv1').should > last_response.body.index('lcd tv2')
    end
  end

end
