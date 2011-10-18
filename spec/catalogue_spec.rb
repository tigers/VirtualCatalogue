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

  it "should not add a product if the id of the given product already exists" do
    # Pre-condition
    catalogue = Catalogue.new
    existing_product = Product.new(0, "", "", "", "", "", "", "", "")
    catalogue.products.push(existing_product)

    # do test
    new_product = Product.new(0, "", "", "", "", "", "", "", "")
    lambda{

      catalogue.add_product(new_product)
    }.should raise_exception()
  end

  it "should add a product if the id of the given product does not exist" do
    # Pre-condition
    catalogue = Catalogue.new
    given_product = Product.new(0, "", "", "", "", "", "", "", "")
    catalogue.products.push(given_product)

    # do test
    new_product = Product.new(1, "", "", "", "", "", "", "", "")
    catalogue.add_product(new_product)
    catalogue.products.index{|p| p.id == 1}.should_not == nil
  end

  it "should not attempt to remove a nil product" do
    lambda {
      catalogue = Catalogue.new
      catalogue.remove_product(nil)
    }.should raise_exception()
  end

  it "should not attempt to remove a product if the id of the given product does not exist" do
    # Pre-condition
    catalogue = Catalogue.new
    existing_product = Product.new(0, "", "", "", "", "", "", "", "")
    catalogue.products.push(existing_product)

    product_to_be_deleted = Product.new(3, "", "", "", "", "", "", "", "")
    lambda {
      catalogue.remove_product(product_to_be_deleted )
    }.should raise_exception()
  end

  it "should return an array of products of which each product's id contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "", "", "", "", "", "", "")
    existing_product2 = Product.new(1, "", "", "", "", "", "", "", "")
    existing_product3 = Product.new(2, "", "", "", "", "", "", "", "")
    existing_product4 = Product.new(3, "", "", "", "", "", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search(3).count.should == 1
  end

  it "should return an array of products of which each product's barcode contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, 12345, "", "", "", "", "", "", "")
    existing_product2 = Product.new(1, 54321, "", "", "", "", "", "", "")
    existing_product3 = Product.new(2, 12867, "", "", "", "", "", "", "")
    existing_product4 = Product.new(3, 12555, "", "", "", "", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search(12).count.should == 3
  end

  it "should return an array of products of which each product's name contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "T850", "", "", "", "", "", "")
    existing_product2 = Product.new(1, "", "X434", "", "", "", "", "", "")
    existing_product3 = Product.new(2, "", "T8000", "", "", "", "", "", "")
    existing_product4 = Product.new(3, "", "D310", "", "", "", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search("T").count.should == 2
  end

  it "should return an array of products of which each product's brand contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "T850", "Sony", "", "", "", "", "")
    existing_product2 = Product.new(1, "", "X434", "LG", "", "", "", "", "")
    existing_product3 = Product.new(2, "", "T8000", "Sony", "", "", "", "", "")
    existing_product4 = Product.new(3, "", "D310", "Hitachi", "", "", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search("Sony").count.should == 2
  end

  it "should return an array of products of which each product's description contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "T850", "Sony", "LCD TV", "", "", "", "")
    existing_product2 = Product.new(1, "", "X434", "LG", "Plasma TV", "", "", "", "")
    existing_product3 = Product.new(2, "", "T8000", "Sony", "Plasma TV", "", "", "", "")
    existing_product4 = Product.new(3, "", "D310", "Hitachi", "Plasma TV", "", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search("Plasma").count.should == 3
  end

  it "should return an array of products of which each product's category contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "T850", "Sony", "LCD TV", "Home Entertainment", "", "", "")
    existing_product2 = Product.new(1, "", "X434", "LG", "Plasma TV", "Home Entertainment", "", "", "")
    existing_product3 = Product.new(2, "", "T8000", "Sony", "Plasma TV", "Home Entertainment", "", "", "")
    existing_product4 = Product.new(3, "", "D310", "Hitachi", "Plasma TV", "Home Entertainment", "", "", "")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search("Entertainment").count.should == 4
  end

  it "should return an array of products of which each product's location contains the search term" do
    catalogue = Catalogue.new
    existing_product1 = Product.new(0, "", "T850", "Sony", "LCD TV", "Home Entertainment", "", "", "GF3A")
    existing_product2 = Product.new(1, "", "X434", "LG", "Plasma TV", "Home Entertainment", "", "", "1F4A")
    existing_product3 = Product.new(2, "", "T8000", "Sony", "Plasma TV", "Home Entertainment", "", "", "1F7A")
    existing_product4 = Product.new(3, "", "D310", "Hitachi", "Plasma TV", "Home Entertainment", "", "", "5F8A")
    catalogue.products.push(existing_product1)
    catalogue.products.push(existing_product2)
    catalogue.products.push(existing_product3)
    catalogue.products.push(existing_product4)

    catalogue.search("1F").count.should == 2
  end

  it "should return an empty array of products if the catalogue does not contain products" do
    catalogue = Catalogue.new
    catalogue.search("some search term").count.should == 0
  end
end