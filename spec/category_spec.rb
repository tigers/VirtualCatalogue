require "rspec"
require '../lib/category'

describe Category do
  let(:filename_category) {"../category_test.csv"}

  before :all do
    create_dummy_category
  end

  def create_dummy_category
      File.open(filename_category, 'w') do |f|
        f.puts("1,TV")
        f.puts("2,SPORTS")
      end
   end

  let(:category) {Category.load(filename_category)}


  it "should raise an exception if the file category.csv doesn't exist" do
      lambda {
        Category.load('anyfile.csv')
      }.should raise_exception()
  end

  it "should not raise an exception if the file category.csv exists" do
      lambda {
        Category.load(filename_category)
      }.should_not raise_exception()
  end

   it "should load the contents of the file into the hash categories" do
     category.should have(2).categories
   end

  it "should raise an exception when incorrect index is given" do
    lambda {
      category.get_category(234)
    }.should raise_exception()
  end

  it "should return category given the index" do
      category.get_category(2).should =="SPORTS"
    end

end


