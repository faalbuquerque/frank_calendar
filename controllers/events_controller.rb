require './controllers/application_controller'
require './models/event'

before '/users/:id/events' do
  return JSON message: 'Nenhum usuário encontrado!' if user.attributes.empty?
end

get '/users/:id/events' do
  if user_signed_in? && current_user.id == user.id

    event = Event.find_by_user_id(user.id)
    return JSON message: 'Nenhum evento cadastrado!' if event.empty?

    event.to_json
  else
    JSON message: 'Faça login para ver seus eventos!'
  end
end

post '/users/:id/events' do
  return JSON message: 'Faça login para criar eventos!' unless user_signed_in?

  if user_signed_in? && current_user.id == user.id

    event = Event.event_new(event_params)

    is_owner_event = event.attributes[:user_id] == user.id
    status 412 and return JSON message: 'Algo deu errado!' unless is_owner_event

    if event.event_save
      event.attributes[:message] = 'Evento criado com sucesso!'
      status 201 and return event.attributes.to_json
    end

    status 422 and event.errors.to_json
  else
    JSON message: 'Faça login para criar eventos!'
  end
end

private

def event_params
  @event_params ||= JSON.parse(request.body.read)
end

def user
  User.find(params['id'])
end
