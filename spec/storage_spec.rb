require 'rspec'
require '../lib/storage.rb'

describe Storage do

  it "products should be empty when the object is created the first time" do
    subject.products.should be_empty
  end

  it "quantity be empty when the object is created the first time" do
    subject.quantity.should be_empty
  end

end