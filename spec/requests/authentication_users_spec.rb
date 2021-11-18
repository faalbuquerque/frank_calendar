require 'spec_helper'

RSpec.describe 'Authentication users' do
  context 'When user tries to authenticate' do
    context 'POST /users/login' do
      it 'authentication user successfully' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)

        params_login = { email: 'ana@ana.com', password: '123456' }.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(res['name']).to eq('ana')
        expect(res['email']).to eq('ana@ana.com')
        expect(res['message']).to eq('Usuario autenticado com sucesso!')
      end

      it 'failure if password blank' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)

        params_login = { email: 'ana@ana.com', password: '' }.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(401)
        expect(res['message']).to eq('Erro de autenticação!')
      end

      it 'failure if email blank' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)

        params_login = { email: '', password: '123456' }.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(401)
        expect(res['message']).to eq('Erro de autenticação!')
      end

      it 'failure if incorrect password' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)

        params_login = { email: '', password: '654321' }.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(401)
        expect(res['message']).to eq('Erro de autenticação!')
      end

      it 'failure if password field is missing' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)

        params_login = { email: 'ana@ana.com' }.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(401)
        expect(res['message']).to eq('Erro de autenticação!')
      end

      it 'failure if all fields are missing' do
        params_login = {}.to_json
        post '/users/login', params_login

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(401)
        expect(res['message']).to eq('Erro de autenticação!')
      end
    end
  end
end
