require 'spec_helper'
require '../lib/catalogue'

describe "Admin Interface" do
  include Rack::Test::Methods

  it "should respond to /admin" do
    get '/admin'
    last_response.should be_ok
  end


end
