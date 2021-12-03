require 'spec_helper'

RSpec.describe 'Create events' do
  context 'when viewing created events' do
    context 'GET /users/:id/events' do
      it 'view existing events' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event_one = { event_name: 'First event', event_location: 'On line, link aqui',
                      event_description: 'Um evento', start_date: '2021-12-01', end_date: '2021-12-02',
                      user_id: user.first.id }
        event_last = { event_name: 'Second event', event_location: 'On line, link lá',
                       event_description: 'Outro evento', start_date: '2022-01-02', end_date: '2022-02-02',
                       user_id: user.first.id }
        EventsQueries.create(event_one)
        EventsQueries.create(event_last)

        get "/users/#{user.first.id.to_i}/events"

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse[0]['event_name']).to eq('First event')
        expect(json_parse[0]['event_location']).to eq('On line, link aqui')
        expect(json_parse[0]['event_description']).to eq('Um evento')
        expect(json_parse[0]['start_date']).to include('2021-12-01')
        expect(json_parse[0]['end_date']).to include('2021-12-02')
        expect(json_parse[0]['user_id']).to eq(user.first.id)
        expect(json_parse[1]['event_name']).to eq('Second event')
        expect(json_parse[1]['event_location']).to eq('On line, link lá')
        expect(json_parse[1]['event_description']).to eq('Outro evento')
        expect(json_parse[1]['start_date']).to include('2022-01-02')
        expect(json_parse[1]['end_date']).to include('2022-02-02')
        expect(json_parse[1]['user_id']).to eq(user.first.id)
      end

      it 'with not existing events' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        get "/users/#{user.first.id.to_i}/events"

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['message']).to eq('Nenhum evento cadastrado!')
      end

      it 'with not logged in' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        get "/users/#{user.first.id.to_i}/events"

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['message']).to eq('Faça login para ver seus eventos!')
      end
    end
  end

  context 'when create events' do
    context 'POST /users/:id/events' do
      it 'create event successfully' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event = { event_name: 'First event', event_location: 'On line, link aqui', event_description: 'Um evento legal',
                  start_date: '2021-12-01', end_date: '2021-12-02', user_id: user.first.id }.to_json

        post "/users/#{user.first.id.to_i}/events", event

        expect(last_response.status).to eq(201)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['event_name']).to eq('First event')
        expect(json_parse['event_location']).to eq('On line, link aqui')
        expect(json_parse['event_description']).to eq('Um evento legal')
        expect(json_parse['start_date']).to eq('2021-12-01')
        expect(json_parse['end_date']).to eq('2021-12-02')
        expect(json_parse['user_id']).to eq(user.first.id)
      end

      it 'with not logged in' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event = { event_name: 'First event', event_location: 'On line, link aqui', event_description: 'Um evento legal',
                  start_date: '2021-12-01', end_date: '2021-12-02', user_id: user.first.id }.to_json

        post "/users/#{user.first.id.to_i}/events", event

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['message']).to eq('Faça login para criar eventos!')
      end

      it 'whith create event for another owner' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('paula@paula.com', '123456')
        ana = User.find_by(name: 'ana').first.attributes

        user_create('paula', 'paula@paula.com', '123456')
        user_login('paula@paula.com', '123456')
        paula = User.find_by(name: 'paula').first.attributes

        event = { event_name: 'First event', event_location: 'On line, link aqui', event_description: 'Um evento',
                  start_date: '2021-12-01', end_date: '2021-12-02', user_id: ana[:id] }.to_json

        post "/users/#{paula[:id].to_i}/events", event

        expect(last_response.status).to eq(412)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['message']).to eq('Algo deu errado!')
      end

      it 'create event logged in with other login' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('paula@paula.com', '123456')
        ana = User.find_by(name: 'ana').first.attributes

        user_create('paula', 'paula@paula.com', '123456')
        user_login('paula@paula.com', '123456')

        event = { event_name: 'First event', event_location: 'On line, link aqui', event_description: 'Um evento',
                  start_date: '2021-12-01', end_date: '2021-12-02', user_id: ana[:id] }.to_json

        post "/users/#{ana[:id].to_i}/events", event

        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['message']).to eq('Faça login para criar eventos!')
      end

      it 'with blank fields' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event = { event_name: '', event_location: '', event_description: '',
                  start_date: '', end_date: '', user_id: user.first.id }.to_json

        post "/users/#{user.first.id.to_i}/events", event

        expect(last_response.status).to eq(422)
        expect(last_response.content_type).to eq('application/json')
        expect(last_response.body).to include('event_name: não pode ficar em branco!')
        expect(last_response.body).to include('event_location: não pode ficar em branco!')
        expect(last_response.body).to include('event_description: não pode ficar em branco!')
        expect(last_response.body).to include('start_date: não pode ficar em branco!')
        expect(last_response.body).to include('end_date: não pode ficar em branco!')
        expect(last_response.body).to include('Não foi possivel criar evento!')
      end

      it 'with missing fields' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event = { event_name: 'First event', user_id: user.first.id }.to_json

        post "/users/#{user.first.id.to_i}/events", event

        expect(last_response.status).to eq(422)
        expect(last_response.content_type).to eq('application/json')
        expect(last_response.body).to include('event_location: campo faltando!')
        expect(last_response.body).to include('event_description: campo faltando!')
        expect(last_response.body).to include('start_date: campo faltando!')
        expect(last_response.body).to include('end_date: campo faltando!')
        expect(last_response.body).to include('Não foi possivel criar evento!')
      end

      it 'with blank fields and missing fields' do
        user_create('ana', 'ana@ana.com', '123456')
        user_login('ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        event = { event_location: '', start_date: '2021-12-01', user_id: user.first.id }.to_json

        post "/users/#{user.first.id.to_i}/events", event

        expect(last_response.status).to eq(422)
        expect(last_response.content_type).to eq('application/json')
        expect(last_response.body).to include('event_name: campo faltando!')
        expect(last_response.body).to include('event_description: campo faltando!')
        expect(last_response.body).to include('end_date: campo faltando!')
        expect(last_response.body).to include('event_location: não pode ficar em branco!')
        expect(last_response.body).to include('Não foi possivel criar evento!')
      end
    end
  end
end
