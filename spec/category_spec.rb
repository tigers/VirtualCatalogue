require "rspec"
require '../lib/category'

describe Category do


    it "category should be empty when the object is created the first time" do
      subject.category.should be_empty
    end
end


