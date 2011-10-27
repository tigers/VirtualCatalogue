require "rspec"
require "../lib/product"

describe Product do

  it "should not accept any parameter to be nil" do
    lambda {product = Product.new(1, 235432452345, "bike", "nomad", "super bike", "bikes", 134, "uri", "second level")}.should_not raise_exception()
  end

  it "id parameter should be integer" do
    product = Product.new(1, 235432452345, "bike", "nomad", "super bike", "bikes", 134, "uri", "second level")
    product.id.class.should == Fixnum
  end

  it "barcode parameter should be integer" do
    product = Product.new(1, 235432452345, "bike1", "nomad", "super bike", "bikes", 134, "uri", "second level")
    product.barcode.class.should == Bignum
  end

  it "price parameter should be integer" do
    product = Product.new(1, 235432452345, "bike", "nomad", "super bike", "bikes", 134, "uri", "second level")
    product.price.class.should == Fixnum
  end

  it "name parameter should be String" do
    product = Product.new(1, 235432452345, "bike", "nomad", "super bike", "bikes", 134, "uri", "second level")
    product.name.class.should == String
  end

end
