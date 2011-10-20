require File.dirname(__FILE__) + '/spec_helper'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
end