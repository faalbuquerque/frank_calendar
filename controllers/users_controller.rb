require './controllers/application_controller'
require './models/user'

get '/users' do
  users = User.all

  if users.empty?
    JSON message: 'Nenhum usuário criado!'
  else
    users.map(&:attributes).to_json
  end
end

get '/users/:id' do
  user = User.find(params['id'])

  if user == []
    JSON message: 'Nenhum usuário encontrado!'
  else
    filtered_pass(user.attributes)

    clean_hash(user.attributes).to_json
  end
end

post '/users' do
  @user = User.user_new(user_params)

  status 201 and return @user.attributes.to_json if @user.user_save

  status 422 and @user.errors.to_json
end

patch '/users/:id' do
  user = User.find(params['id'])

  if user == []
    JSON message: 'Nenhum usuário encontrado!'
  elsif user.user_update(user_params)
    user_params['message'] = 'Usuário atualizado!'

    filtered_pass(user_params)
    clean_hash(user_params).to_json
  else
    status 422 and JSON message: 'Não foi possivel atualizar!'
  end
end

private

def user_params
  @user_hash ||= JSON.parse(request.body.read)

  @user_hash['password_digest'] = BCrypt::Password.create(@user_hash['password_digest']) if @user_hash['password']

  @user_hash
end
