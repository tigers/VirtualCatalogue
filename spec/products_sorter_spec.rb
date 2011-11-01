require 'rspec'
require '../lib/product'
require '../lib/product_sorter'

describe "Products Sorter" do
  let(:products) {
    [Product.new(2, 12345678, "lcd tv1","sony", "lcd tv", 3, 2000, "1.jpg","level2"),
     Product.new(1, 23424678, "lcd tv2","panasonic", "lcd tv", 2, 1000, "2.jpg","level2"),
     Product.new(6, 1234567890, "iPad", "Apple", "Very expensive product!", 4, 500.99, "ipad.jpg", "GFA1"),
     Product.new(5, 123687, "iPhone", "Apple", "Another very expensive product!", 4, 500.00, "iphone.jpg", "GFA2")]
  }

  it "should sort by ascending ID when the field and order parameters are not specified" do
    result = Product_Sorter.sort products
    (result[0].id == 1 && result[-1].id == 6).should == true
  end

  it "should sort by ascending ID when the field is 'ID' and order parameter is ascending" do
    result = Product_Sorter.sort products, :id, :ascending
    (result[0].id == 1 && result[-1].id == 6).should == true
  end

  it "should sort by descending ID when the field is 'ID' and order parameter is descending" do
    result = Product_Sorter.sort products, :id,:descending
    (result[0].id == 6 && result[-1].id == 1).should == true
  end

  it "should sort by ascending ID when the field is 'ID' and order parameter is not specified" do
    result = Product_Sorter.sort products, :id
    (result[0].id == 1 && result[-1].id == 6).should == true
  end

  it "should sort by ascending price when the field is 'Price' and order parameter is ascending" do
    result = Product_Sorter.sort products, :price, :ascending
    (result[0].id == 5 && result[-1].id == 2).should == true
  end

  it "should sort by descending price when the field is 'Price' and order parameter is descending" do
    result = Product_Sorter.sort products, :price, :descending
    (result[0].id == 2 && result[-1].id == 5).should == true
  end

  it "should sort by ascending price when the field is 'Price' and order parameter is not specified" do
    result = Product_Sorter.sort products, :price
    (result[0].id == 5 && result[-1].id == 2).should == true
  end

  it "should sort by ascending name when the field is 'name' and order parameter is ascending" do
    result = Product_Sorter.sort products, :name, :ascending
    (result[0].id == 6 && result[-1].id == 1).should == true
  end

  it "should sort by descending name when the field is 'name' and order parameter is descending" do
    result = Product_Sorter.sort products, :name, :descending
    (result[0].id == 1 && result[-1].id == 6).should == true
  end

  it "should sort by ascending name when the field is 'name' and order parameter is not specified" do
    result = Product_Sorter.sort products, :name
    (result[0].id == 6 && result[-1].id == 1).should == true
  end

  it "should sort by ascending brand when the field is 'brand' and order parameter is ascending" do
    result = Product_Sorter.sort products, :brand, :ascending
    (result[0].brand == "Apple" && result[-1].brand == "sony").should == true
  end

   it "should sort by descending brand when the field is 'brand' and order parameter is descending" do
    result = Product_Sorter.sort products, :brand, :descending
    (result[0].brand == "sony" && result[-1].brand =="Apple" ).should == true
   end
   it "should sort by ascending brand when the field is 'brand' and order parameter is not specified" do
    result = Product_Sorter.sort products, :brand
    (result[0].brand == "Apple" && result[-1].brand == "sony").should == true
  end
end