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
    json = user.attributes

    json.tap { |hash| hash['password'] = 'FILTERED' }
    json.delete('password_digest')

    json.to_json
  end
end

post '/users' do
  @user = User.user_new(user_params)

  status 201 and return @user.attributes.to_json if @user.user_save

  status 422 and @user.errors.to_json
end

private

def user_params
  json = JSON.parse(request.body.read)
  json.tap do |hash|
    hash['password_digest'] = BCrypt::Password.create(hash['password']) if hash['password']
  end
  json.delete('password')

  json
end
