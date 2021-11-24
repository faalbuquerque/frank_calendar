require 'simplecov'

SimpleCov.start

require 'pg'
require 'rack/test'
require 'rspec'

require './dependencies/rspec'

ENV['DATABASE'] = 'test'

TEST_BCRYPT_COST = 6
BCrypt::Engine.cost = TEST_BCRYPT_COST.freeze

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include UserHelper
  config.include JsonHelper

  config.after(:each) do
    DataBase.clean_db
  end
end
