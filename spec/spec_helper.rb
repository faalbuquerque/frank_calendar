require 'simplecov'

SimpleCov.start

require './app'
require 'rspec'
require 'rack/test'
require 'pg'
require_relative '../config/data_base'

ENV['DATABASE'] = 'test'

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.after(:each) do
    DataBase.clean_db
  end
end
