require 'rspec'

describe "Product" do

  it "Just en empty product" do
    subject.id.should == 0
  end
end