require 'spec_helper'

RSpec.describe 'Update users' do
  context 'when edit users' do
    context 'PATCH /users/:id' do
      it 'successfully update a field' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        update_user = { email: 'ana_paula@ana.com' }

        patch "/users/#{user.first.id}", update_user.to_json

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['email']).to eq('ana_paula@ana.com')
      end

      it 'update user successfully' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        update_user = { id: user.first.id.to_s, name: 'anajulia', email: 'anajulia@ana.com', password_digest: '654321' }

        patch "/users/#{user.first.id}", update_user.to_json

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['name']).to eq('anajulia')
        expect(json_parse['email']).to eq('anajulia@ana.com')
        expect(json_parse['name']).to_not eq('ana')
        expect(json_parse).to_not include('ana@ana.com')
      end

      it 'failure update if field blank' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        update_user = { id: user.first.id, name: '', email: '', password_digest: '' }

        patch "/users/#{user.first.id}", update_user.to_json

        expect(last_response.status).to eq(422)
        expect(last_response.content_type).to eq('application/json')
        expect(last_response.body).to include('Não foi possível atualizar!')
        expect(last_response.body).to include('name: não pode ficar em branco!')
        expect(last_response.body).to include('email: não pode ficar em branco!')
        expect(last_response.body).to include('password_digest: não pode ficar em branco!')
      end

      it 'failure update if invalid email' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        update_user = { id: user.first.id.to_s, name: 'maria', email: 'mariaaaa.com', password_digest: '123456' }

        patch "/users/#{user.first.id}", update_user.to_json

        expect(last_response.status).to eq(422)
        expect(last_response.content_type).to eq('application/json')
        expect(last_response.body).to include('Não foi possível atualizar!')
        expect(last_response.body).to include('Email inválido!')
      end
    end
  end
end
