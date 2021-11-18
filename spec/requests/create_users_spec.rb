require 'spec_helper'

RSpec.describe 'Create users' do
  context 'when viewing created users' do
    context 'GET /users' do
      it 'view existing users' do
        users = []
        users << { name: 'ana', email: 'ana@ana.com', password_digest: '123456' }
        users << { name: 'joana', email: 'joana@ana.com', password_digest: '123456' }

        users.each { |user| UsersQueries.create(user) }

        get '/users'

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(res.first['name']).to eq('ana')
        expect(res.first['email']).to eq('ana@ana.com')
        expect(res.last['name']).to eq('joana')
        expect(res.last['email']).to eq('joana@ana.com')
      end

      it 'there are no users' do
        get '/users'

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(res['message']).to eq('Nenhum usuário criado!')
      end
    end
  end

  context 'when create users' do
    context 'POST /users' do
      it 'create user successfully' do
        user = { name: 'ana', email: 'ana@ana.com', password_digest: '123456' }.to_json

        post '/users', user

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(201)
        expect(last_response.content_type).to eq('application/json')
        expect(res['name']).to eq('ana')
        expect(res['email']).to eq('ana@ana.com')
      end

      it 'with invalid email' do
        user = { name: 'Fernanda', email: 'fefefe' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('Email inválido!')
      end

      it 'with blank fields' do
        user = { name: '', email: '' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('name: não pode ficar em branco!')
        expect(last_response.body).to include('email: não pode ficar em branco!')
      end

      it 'with invalid email and blank fields' do
        user = { name: '', email: 'fefefe' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('name: não pode ficar em branco!')
        expect(last_response.body).to include('Email inválido!')
      end

      it 'with missing fields' do
        user = { name: 'Fernanda' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('email: campo faltando!')
      end

      it 'with blank fields and missing fields' do
        user = { name: '' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('email: campo faltando!')
        expect(last_response.body).to include('name: não pode ficar em branco!')
      end

      it 'with invalid email and missing fields' do
        user = { email: 'aaaaa' }.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('name: campo faltando!')
        expect(last_response.body).to include('Email inválido!')
      end

      it 'with all empty' do
        user = {}.to_json

        post '/users', user

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('name: campo faltando!')
        expect(last_response.body).to include('email: campo faltando!')
      end

      it 'with email already registered' do
        user = { name: 'ana', email: 'ana@ana.com', password_digest: '123456' }.to_json
        post '/users', user

        user_already = { name: 'ana', email: 'ana@ana.com', password_digest: '123456' }.to_json
        post '/users', user_already

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include('Este email já foi utilizado!')
      end
    end
  end
end
