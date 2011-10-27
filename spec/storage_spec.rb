require 'rspec'
require '../lib/storage'
require '../lib/product'

describe Storage do
  let(:filename) {"../products_test.csv"}
  let(:filename_quantity) {"../quantity_test.csv"}

  before :all do
    create_dummy_products
    create_dummy_quantity
  end

  def create_dummy_products
     File.open(filename, 'w') do |f|
       f.puts("1,12345678,lcd tv,sony,lcd tv,TV,1000,1.jpg,level2")
       f.puts("2,55555555,bike XYZ,oxford,super bike,SPORTS,500,2.jpg,level1")
     end
  end

  def create_dummy_quantity
    File.open(filename_quantity,'w') do |fq|
      fq.puts("1,5")
      fq.puts("2,15")
    end
  end

  context "About products" do
    it "products should be empty when the object is created the first time" do
      subject.products.should be_empty
    end

    it "should raise and exception if the file products.csv doesn't exist" do
      lambda {
        subject.load_products_file 'anyfile.csv'
      }.should raise_exception()
    end

    it "should not raise an exception if the file products.csv exists" do
      lambda {
        subject.load_products_file filename
      }.should_not raise_exception()
    end


    it "should load the contents of the file into array products" do
      subject.load_products_file filename
      subject.should have(2).products
    end

    it "should contain only product" do
      subject.load_products_file()
      subject.products.each do | p |
        p.should be_an_instance_of Product
      end
    end
  end

  context "About quantity" do
    it "quantity should be empty when the object is created" do
      subject.quantity.should be_empty
    end

    it "should raise an exception if the file quantity.csv doesn't exist" do
      lambda {
        subject.load_quantity_file 'anyfile.csv'
      }.should raise_exception()
    end

    it "should not raise an exception if the file quantity.csv exists" do
      lambda {
        subject.load_quantity_file filename_quantity
      }.should_not raise_exception()
    end

    it "should load the contents of the file into array quantity" do
      subject.load_quantity_file filename_quantity
      subject.should have(2).quantity
    end

    it "should return quantity given the id" do
      subject.load_quantity_file filename_quantity
      i = subject.get_quantity(2)
      i.should == 15
    end

  end

  context "Editing functions" do








    it "should add products to products.csv file" do

      lambda {
        product = Product.new("23", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")

      subject.load_products_file filename
      subject.add_product(product)}.should_not raise_exception()

    end
    it "should contains added product" do
          product = Product.new("23", "23452345", "pc", "dell", "computers in the labs", "7", "200", "comp.jpg", "somewhere")
          subject.products.each do |p|
            p.id.to_i.should == product.id.to_i
          end
    end

  end
end



