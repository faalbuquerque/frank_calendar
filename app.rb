require 'sinatra'
require 'json'
require 'net/http'
require_relative 'models/user'

get '/' do
  'Home Frank Calendar! =)'
end

get '/users' do
  users = User.all
  content_type 'application/json'

  if users.empty?
    JSON message: 'Nenhum usuário criado!'
  else
    users.map(&:attributes).to_json
  end
end

post '/users' do
  content_type 'application/json'

  @user = User.user_new(user_params)

  status 201 and return @user.attributes.to_json if @user.user_save

  status 422 and @user.errors.to_json
end

private

def user_params
  JSON.parse(request.body.read)
end
