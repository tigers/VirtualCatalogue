require 'spec_helper'
require '../lib/catalogue'

describe "Admin Interface" do
  include Rack::Test::Methods

  it "should respond to /admin" do
    get '/admin'
    last_response.should be_ok
  end

  it "should respond to post /productform" do
    post '/productform'
    last_response.should be_ok
  end

end
