require 'spec_helper'

RSpec.describe 'User' do
  context 'GET' do
    context '/users' do
      it 'successfully' do
        users = []
        users << { name: 'ana', email: 'ana@ana.com' }
        users << { name: 'joana', email: 'joana@ana.com' }

        users.each { |user| User.create(user) }

        get '/users'

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(res.first['name']).to eq('ana')
        expect(res.first['email']).to eq('ana@ana.com')
        expect(res.last['name']).to eq('joana')
        expect(res.last['email']).to eq('joana@ana.com')
      end

      it 'no data' do
        get '/users'

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(res['message']).to eq('Nenhum usuário criado!')
      end
    end
  end

  context 'POST' do
    context '/users' do
      it 'successfully' do
        user = { name: 'ana', email: 'ana@ana.com' }.to_json

        post '/users', user

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(201)
        expect(last_response.content_type).to eq('application/json')
        expect(res['name']).to eq('ana')
        expect(res['email']).to eq('ana@ana.com')
      end

      it 'data in blank' do
        user = { name: '', email: '' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('name: não pode ficar em branco!')
        expect(last_response.body).to include('email: não pode ficar em branco!')
      end
    end
  end
end
