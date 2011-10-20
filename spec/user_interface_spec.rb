require 'spec_helper'

describe "User Interface" do
  include Rack::Test::Methods

  it "should respond to /" do
    get '/'
    [200, 302].should include(last_response.status)
  end

  it "should respond to / and redirect to /index.html" do
    get '/'
    last_response.status.should == 302
    last_response.headers.should include 'Location'
    last_response.headers['Location'].should include 'index.html'
  end

  #it "should load the storage object when it starts" do
  #  app.settings.should have_
  #end
end
