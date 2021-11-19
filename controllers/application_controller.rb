require 'sinatra'
require './helpers/modules/users/authentication'

set :default_content_type, :json
set :sessions, true

helpers Authentication
