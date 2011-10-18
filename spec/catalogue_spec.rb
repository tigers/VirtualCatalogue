require '../catalogue'
require "rspec"

describe "Catalogue" do

  it "should return a non-nil value for the products property" do
    catalogue = Catalogue.new
    catalogue.products.should_not == nil
  end

end