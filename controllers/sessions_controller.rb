require 'sinatra'
require 'sinatra/cookies'
require './helpers/modules/users/session'
require './models/user'

set :default_content_type, :json

helpers Authentication

post '/users/login' do
  user = User.user_new(sign_in(login_params))

  if user.attributes.empty?
    status 401 and JSON message: 'Erro de autenticação!'
  else
    json = user.attributes

    json.tap do |hash|
      hash['password'] = 'FILTERED'
      hash['message'] = 'Usuario autenticado com sucesso!'
    end
    json.delete('password_digest')

    json.to_json
  end
end

private

def login_params
  json = JSON.parse(request.body.read)
  { email: json['email'], password: json['password'] }
end
