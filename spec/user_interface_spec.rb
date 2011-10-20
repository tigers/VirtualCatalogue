require 'spec_helper'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

  it "should respond to / and redirect to /index.html" do
    get '/'
    last_response.status.should == 302
    last_response.headers.should include 'Location'
    last_response.headers['Location'].should include 'index.html'
  end

end
