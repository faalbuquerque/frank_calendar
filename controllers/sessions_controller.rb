require './controllers/application_controller'
require './models/user'

post '/users/login' do
  user = User.find_by(email: login_params[:email]).first

  if user&.authenticate(login_params[:password])
    hash = user.attributes

    hash.delete(:password_digest)

    session[:user] = hash

    json = user.attributes

    json.tap do |hash_user|
      hash_user['password'] = 'FILTERED'
      hash_user['message'] = 'Usuario autenticado com sucesso!'
    end

    json.delete('password_digest')

    json.to_json
  else
    session[:user] = nil
    status 401 and JSON message: 'Erro de autenticação!'
  end
end

private

def login_params
  @json ||= JSON.parse(request.body.read)
  { email: @json['email'], password: @json['password'] }
end
