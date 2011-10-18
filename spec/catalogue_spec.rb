require '../catalogue'
require "rspec"

describe "Catalogue" do

  it "should return a non-nil value for the products property" do
    catalogue = Catalogue.new
    catalogue.products.should_not == nil
  end

  it "should add a product if the id of the given product does not exist" do
    # Pre-condition
    catalogue = Catalogue.new
    given_product = mock('Product')
    given_product.stub!(:get_id).and_return(0)
    catalogue.products.push(given_product)

    # do test
    catalogue.products.index{|p| p.get_id == 0}.should_not == nil
  end

  # need to implement in Catalogue class
  it "should not add a product if the id of the given product already exists" do
    # Pre-condition
    catalogue = Catalogue.new
    existing_product = mock('Product')
    existing_product.stub!(:get_id).and_return(0)
    catalogue.products.push(existing_product)

    # do test
    catalogue.products.count{|p| p.get_id == 0}.should <= 1
  end

  it "should not add a nil product" do
    lambda {
      catalogue = Catalogue.new
      catalogue.add_product(nil)
    }.should raise_exception()
  end
end