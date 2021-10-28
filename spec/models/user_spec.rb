require 'spec_helper'

RSpec.describe 'User' do
  context '.user_new' do
    context 'new user' do
      it 'successfully' do
        data = { name: 'tester', email: 'tester@email.com' }
        user = User.user_new(data)

        expect(user.attributes[:name]).to eq('tester')
        expect(user.attributes[:email]).to eq('tester@email.com')
      end
    end
  end

  context '#user_save' do
    context 'save user' do
      it 'successfully' do
        params = { name: 'abacate', email: 'abacate@email.com' }
        user = User.user_new(params)
        UsersQueries.create(user.attributes)

        expect(user.attributes[:name]).to eq('abacate')
        expect(user.attributes[:email]).to eq('abacate@email.com')
      end
    end
  end

  context '.all' do
    context 'fetch all users' do
      it 'successfully' do
        user_first = { name: 'User First', email: 'user_first@email.com' }
        UsersQueries.create(user_first)

        user_last = { name: 'User Last', email: 'user_last@email.com' }
        UsersQueries.create(user_last)

        user_all = User.all.map!(&:name)

        expect(user_all).to include('User First')
        expect(user_all).to include('User Last')
      end
    end
  end
end
