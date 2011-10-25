require "rspec"
require '../lib/category'

describe Category do

  let(:filename_category) {"../category_test.csv"}

  it "category should be empty when the object is created the first time" do
      subject.category.should be_empty
    end

  it "should raise an exception if the file category.csv doesn't exist" do
      lambda {
        subject.load_category_file 'anyfile.csv'
      }.should raise_exception()
  end

  it "should not raise an exception if the file category.csv exists" do
      lambda {
        subject.load_category_file filename_category
      }.should_not raise_exception()
    end



end


