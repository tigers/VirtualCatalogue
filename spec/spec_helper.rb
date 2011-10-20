require '../lib/user_interface'
require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'

# set test environment
set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Sinatra::Application
  #def app() UserInterface end
end