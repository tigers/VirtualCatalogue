require "../lib/catalogue"
require "../lib/product"
require "rspec"

describe "Catalogue" do

  it "should return a non-nil value for the 'products' property" do
    catalogue = Catalogue.new
    catalogue.products.should_not == nil
  end


  it "should initially have an empty new product id " do
          catalogue = Catalogue.new
          catalogue.newProductId.should == nil
  end



  context "interacting with the product database" do
    let(:catalogue) { Catalogue.new }
    let(:existing_product1) { Product.new(0, "12345", "T850", "Sony", "LCD TV", 1, "", "", "GF3A") }
    before :all do
      existing_product2 = Product.new(1, "54321", "X434", "LG", "Plasma TV", 1, "", "", "1F4A")
      existing_product3 = Product.new(2, "12867", "T8000", "Sony", "Plasma TV", 1, "", "", "1F7A")
      existing_product4 = Product.new(3, "12555", "D310", "Hitachi", "Plasma TV", 2, "", "", "5F8A")
      catalogue.products.push(existing_product1)
      catalogue.products.push(existing_product2)
      catalogue.products.push(existing_product3)
      catalogue.products.push(existing_product4)


    end

    it "should not add a nil product" do
      lambda {
        catalogue.add_product(nil)
      }.should raise_exception()
    end

    it "should not add a product if the id of the given product already exists" do
      new_product = Product.new(0, "", "", "", "", "", "", "", "")
      lambda {
        catalogue.add_product(new_product)
      }.should raise_exception()
    end

    it "should add a product if the id of the given product does not exist" do
      new_product = Product.new(4, "", "", "", "", "", "", "", "")
      catalogue.add_product(new_product)
      catalogue.products.index{|p| p.id == 4}.should_not == nil
    end

    it "should not attempt to remove a nil product" do
      lambda {
        catalogue.remove_product(nil)
      }.should raise_exception()
    end

    it "should not attempt to remove a product if the id of the given product does not exist" do
      product_to_be_deleted = Product.new(5, "", "", "", "", "", "", "", "")
      lambda {
        catalogue.remove_product(product_to_be_deleted)
      }.should raise_exception()
    end

    it "should not attempt to get a nil product" do
      lambda {
        catalogue.get_product(nil)
      }.should raise_exception()
    end

    it "should not attempt to get a product when the specified product ID does not exist" do
      lambda {
        catalogue.get_product(-1)
      }.should raise_exception()
    end

    it "should return the product which has the specified ID when attempting to get the product from the catalogue" do
      catalogue.get_product(0).should == existing_product1
    end

    it "should return an empty array of products if the catalogue does not contain products" do
      catalogue.search("some search term").count.should == 0
    end

    it "should return an array of products of which each product's id contains the search term" do
      catalogue.search(0).count.should == 3
    end

    it "should return an array of products of which each product's barcode contains the search term" do
      catalogue.search(12).count.should == 3
    end

    it "should return an array of products of which each product's name contains the search term" do
      (catalogue.search("T").count == catalogue.search("t").count).should == true
    end

    it "should return an array of products of which each product's brand contains the search term" do
      catalogue.search("Sony").count.should == 2
    end

    it "should return an array of products of which each product's description contains the search term" do
      catalogue.search("Plasma").count.should == 3
    end

    it "should return an array of products of which each product's location contains the search term" do
      catalogue.search("1F").count.should == 2
    end
    it "should return an array of products that matches to all parameters of search_term" do
      catalogue.search("sony", 0).count.should == 2
    end
    it "should return an array of products that matches to specific category of search_term" do
      catalogue.search("sony", 1).count.should == 2
      catalogue.search("tv", 2).count.should == 1
    end
    it "should edit a product if the id of the given product does exist" do
      new_product5 = Product.new(5, "sony", "", "", "", "", "14", "", "")
      catalogue.add_product(new_product5)
      edit_product5 =   Product.new(5, "panasonic", "", "", "", "", "45", "", "")
      catalogue.products.index{|p| p.id == edit_product5.id }.should_not == nil
      catalogue.edit_product(edit_product5)

    end

    it "should not edit a product if the id of the given product does not exists" do
      new_product6 = Product.new(6, "", "", "", "", "", "", "", "")
      lambda {
        catalogue.edit_product(new_product6)
      }.should raise_exception()
    end


    it "should not edit a nil product" do
      lambda {
        catalogue.edit_product(nil)
      }.should raise_exception()
    end

    it "should not return a non nil new_product_id" do
       catalogue.get_new_product_id.should_not == nil
       new_product_id1 = catalogue.get_new_product_id
       new_product7 = Product.new(new_product_id1, "", "", "", "", "", "", "", "")
       catalogue.add_product(new_product7)
       new_product_id2 = catalogue.get_new_product_id
       new_product8 = Product.new(new_product_id2, "", "", "", "", "", "", "", "")
       catalogue.add_product(new_product8)
    end

    #it "should not return a new_product_id that corresponds to an existing product id" do

        #lambda {
        #catalogue.get_new_product_id != 6
      #}.should raise_exception()
    #end



  end



end