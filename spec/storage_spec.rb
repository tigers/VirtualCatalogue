require 'rspec'
require '../lib/storage.rb'

describe Storage do
  let(:filename) {"../products_test.csv"}

  before :all do
    create_dummy_data
  end


  def create_dummy_data
     File.open(filename, 'w') do |f|
       f.puts("1,12345678,lcd tv,sony,lcd tv,TV,1000,1.jpg,level2")
       f.puts("2,55555555,bike XYZ,oxford,super bike,SPORTS,500,2.jpg,level1")
     end
  end

  it "products should be empty when the object is created the first time" do
    subject.products.should be_empty
  end

  it "quantity be empty when the object is created the first time" do
    subject.quantity.should be_empty
  end

  it "should raise and exception if the file products.csv doesnt exist" do
    lambda {
      subject.load_products_file 'anyfile.csv'
    }.should raise_exception()
  end

  it "should not raise and exception if the file products.csv exists" do
    lambda {
      subject.load_products_file filename
    }.should_not raise_exception()
  end

  #it "should check the file products.csv exists and is not empty" do
  #  lambda {
  #    subject.load_products_file()
  #  }.should_not raise_exception()

  #  subject.should have_at_least(1).products
  #end

 # it "should load the contents of the file into array products" do
 #   subject.load_products_file()
 #   subject.should have(2).products
 # end

end