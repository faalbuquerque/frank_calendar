require 'spec_helper'

RSpec.describe 'Authentication users' do
  context 'When user tries to authenticate' do
    context 'POST /users/login' do
      it 'authentication user successfully' do
        user_create('ana', 'ana@ana.com', '123456')

        user_login('ana@ana.com', '123456')

        expect(last_response.status).to eq(200)
        expect(json_parse['name']).to eq('ana')
        expect(json_parse['email']).to eq('ana@ana.com')
        expect(json_parse['message']).to eq('Usuario autenticado com sucesso!')
      end

      it 'failure if password blank' do
        user_create('ana', 'ana@ana.com', '123456')

        user_login('ana@ana.com', '')

        expect(last_response.status).to eq(401)
        expect(json_parse['message']).to eq('Erro de autenticação!')
      end

      it 'failure if email blank' do
        user_create('ana', 'ana@ana.com', '123456')

        user_login('', '123456')

        expect(last_response.status).to eq(401)
        expect(json_parse['message']).to eq('Erro de autenticação!')
      end

      it 'failure if incorrect password' do
        user_create('ana', 'ana@ana.com', '123456')

        user_login('ana@ana.com', '1234456')

        expect(last_response.status).to eq(401)
        expect(json_parse['message']).to eq('Erro de autenticação!')
      end

      it 'failure if password field is missing' do
        user_create('ana', 'ana@ana.com', '123456')

        params_login = { name: 'ana' }.to_json
        post '/users/login', params_login

        expect(last_response.status).to eq(401)
        expect(json_parse['message']).to eq('Erro de autenticação!')
      end

      it 'failure if all fields are missing' do
        params_login = {}.to_json
        post '/users/login', params_login

        expect(last_response.status).to eq(401)
        expect(json_parse['message']).to eq('Erro de autenticação!')
      end
    end
  end
end
