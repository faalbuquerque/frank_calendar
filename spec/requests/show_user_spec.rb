require 'spec_helper'

RSpec.describe 'Show user' do
  context 'When trying to view a user' do
    context 'GET /users/:id' do
      it 'return user if user exist' do
        user_create('ana', 'ana@ana.com', '123456')

        user = User.find_by(name: 'ana')

        get "/users/#{user.first.id}"

        expect(last_response.status).to eq(200)
        expect(json_parse['name']).to eq('ana')
        expect(json_parse['email']).to eq('ana@ana.com')
        expect(json_parse['password']).to eq('FILTERED')
      end

      it 'return error message if not exist' do
        get '/users/777'

        expect(json_parse['message']).to eq('Nenhum usuário encontrado!')
      end
    end
  end
end
