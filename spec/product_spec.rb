require "rspec"
require "../lib/product"

describe Product do

  it "should not accept any parameter to be nil" do

    lambda {product = Product.new("bike", "spec", "location", 234, 23423452345)}.should_not raise_exception()

  end
  it "id parameter should be integer" do
    product = Product.new("bike", "spec", "location", 2345 , 23423452345)
    product.id.class.should == Fixnum

  end
  it "barcode parameter should be integer" do
    product = Product.new("bike", "spec", "location", 234 , 23423452345)
    product.barcode.class.should == Bignum

  end
  it "name parameter should be String" do
    product = Product.new("bike", "spec", "location", 2345, 23423452345)
    product.name.class.should == String

  end

end