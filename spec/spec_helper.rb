require 'simplecov'

SimpleCov.start

require './controllers/users_controller'
require './controllers/home_controller'
require './controllers/sessions_controller'
require 'rspec'
require 'rack/test'
require 'pg'
require_relative '../config/data_base'
require_relative './support/user_helper'
require_relative './support/json_helper'

ENV['DATABASE'] = 'test'
BCrypt::Engine.cost = 6

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
