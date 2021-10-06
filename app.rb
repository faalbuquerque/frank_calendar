require 'sinatra'
require 'json'
require_relative 'models/user'

get '/' do
  'Home Frank Calendar! =)'
end

post '/users' do
  User.create(user_params).to_json
end

private

def user_params
  JSON.parse(request.body.read)
end
