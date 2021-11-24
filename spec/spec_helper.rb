require 'simplecov'

SimpleCov.start

require 'pg'
require 'rack/test'
require 'rspec'

require './dependencies/rspec'

ENV['DATABASE'] = 'test'

BCRYPT_COST = 6.freeze
BCrypt::Engine.cost = BCRYPT_COST

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
