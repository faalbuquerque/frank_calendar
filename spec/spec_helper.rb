require 'simplecov'

SimpleCov.start

require 'byebug'
require './app'
require 'rspec'
require 'rack/test'

ENV['DATABASE'] = 'test'

def app
  Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
