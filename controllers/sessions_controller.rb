require './controllers/application_controller'

post '/users/login' do
  user = User.find_by(email: login_params[:email]).first

  if user&.authenticate(login_params[:password])
    session[:user] = clean_hash(user.attributes)

    filtered_pass(user.attributes)

    user.attributes['message'] = 'Usuario autenticado com sucesso!'

    clean_hash(user.attributes).to_json
  else
    session[:user] = nil
    status 401 and JSON message: 'Erro de autenticação!'
  end
end

private

def login_params
  @hash_login ||= JSON.parse(request.body.read)
  { email: @hash_login['email'], password: @hash_login['password'] }
end
