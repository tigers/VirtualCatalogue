require "../lib/catalogue"
require "../lib/product"
require "rspec"

describe "Catalogue" do

  it "should return a non-nil value for the 'products' property" do
    catalogue = Catalogue.new
    catalogue.products.should_not == nil
  end

  it "should not add a nil product" do
    lambda {
      catalogue = Catalogue.new
      catalogue.add_product(nil)
    }.should raise_exception()
  end

  # need to implement in Catalogue class
  it "should not add a product if the id of the given product already exists" do
    # Pre-condition
    catalogue = Catalogue.new
    existing_product = Product.new("", "", "", 0, 01234)
    catalogue.products.push(existing_product)

    # do test
    new_product = Product.new("", "", "", 0, 01234)
    lambda{

      catalogue.add_product(new_product)
    }.should raise_exception()

  end

  it "should add a product if the id of the given product does not exist" do
    # Pre-condition
    catalogue = Catalogue.new
    given_product = Product.new("", "", "", 0, 01234)
    catalogue.products.push(given_product)

    # do test
    new_product = Product.new("", "", "", 1, 01234)
    catalogue.add_product(new_product)
    catalogue.products.index{|p| p.id == 1}.should_not == nil
  end

  it "should not attempt to remove a nil product" do
    lambda {
      catalogue = Catalogue.new
      catalogue.remove_product(nil)
    }.should raise_exception()
  end

  # need to implement in Catalogue class
  it "should not attempt to remove a product if the id of the given product does not exist" do
    # Pre-condition
    catalogue = Catalogue.new
    existing_product = Product.new("", "", "", 0, 01234)
    catalogue.products.push(existing_product)

    product_to_be_deleted = Product.new("","","", 3, 3334)
     lambda {
      catalogue.remove_product(product_to_be_deleted )
    }.should raise_exception()

  end

end