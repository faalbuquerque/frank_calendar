require 'sinatra'
require './helpers/modules/users/authentication'
require './helpers/modules/clean_attributes'

set :default_content_type, :json
set :sessions, true

helpers Authentication
helpers CleanAttributes
