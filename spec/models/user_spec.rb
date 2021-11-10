require 'spec_helper'

RSpec.describe 'User' do
  context '.user_new' do
    context 'when have new attributes' do
      it 'pass attributes to user' do
        params = { name: 'tester', email: 'tester@email.com', password_digest: '123456' }
        user = User.user_new(params)

        expect(user.attributes[:name]).to eq('tester')
        expect(user.attributes[:email]).to eq('tester@email.com')
      end
    end
  end

  context '#user_save' do
    context 'when valid attributes' do
      it 'persist user successfully' do
        params = { name: 'abacate', email: 'abacate@email.com', password_digest: '123456' }
        user = User.user_new(params)
        user.user_save

        expect(user.attributes[:name]).to eq('abacate')
        expect(user.attributes[:email]).to eq('abacate@email.com')
      end
    end

    context 'when attributes in blank' do
      it 'not persist user' do
        params = { name: '', email: '', password_digest: '' }
        user = User.user_new(params)
        user.user_save

        expect(user.errors).to include('Não foi possível salvar!')
      end
    end

    context 'when invalid email' do
      it 'not persist user' do
        params = { name: 'Ana', email: 'anananana' }
        user = User.user_new(params)
        user.user_save

        expect(user.errors).to include('Não foi possível salvar!')
      end
    end

    context 'when fields are missing' do
      it 'not persist user' do
        params = { name: 'Ana' }
        user = User.user_new(params)
        user.user_save

        expect(user.errors).to include('Não foi possível salvar!')
      end
    end
  end

  context '.all' do
    context 'when there are multiple users' do
      it 'returns list of all users' do
        params = { name: 'User First', email: 'user_first@email.com', password_digest: '123456' }
        UsersQueries.create(params)

        params = { name: 'User Last', email: 'user_last@email.com', password_digest: '123456' }
        UsersQueries.create(params)

        user_all = User.all.map!(&:name)

        expect(user_all).to include('User First')
        expect(user_all).to include('User Last')
      end
    end
  end
end
