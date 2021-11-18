require 'spec_helper'

RSpec.describe 'Show user' do
  context 'When trying to view a user' do
    context 'GET /users/:id' do
      it 'return user if user exist' do
        password = BCrypt::Password.create('123456')
        params = { name: 'ana', email: 'ana@ana.com', password_digest: password }
        UsersQueries.create(params)
        user = User.find_by(name: 'ana')

        get "/users/#{user.first.id}"

        res = JSON.parse(last_response.body)

        expect(last_response.status).to eq(200)
        expect(res['name']).to eq('ana')
        expect(res['email']).to eq('ana@ana.com')
        expect(res['password']).to eq('FILTERED')
      end

      it 'return error message if not exist' do
        get '/users/777'

        res = JSON.parse(last_response.body)

        expect(res['message']).to eq('Nenhum usuário encontrado!')
      end
    end
  end
end
