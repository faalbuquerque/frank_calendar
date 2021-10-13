require 'spec_helper'

RSpec.describe 'User' do
  context 'create' do
    it 'successfully' do
      user_data = { name: 'tester', email: 'tester@email.com' }
      user = User.create(user_data)

      expect(user[:name]).to eq('tester')
      expect(user[:email]).to eq('tester@email.com')
    end
  end

  context 'fetch all' do
    it 'successfully' do
      user_first = { name: 'User First', email: 'user_first@email.com' }
      User.create(user_first)

      user_last = { name: 'User Last', email: 'user_last@email.com' }
      User.create(user_last)

      user_all = User.all.map!(&:name)

      expect(user_all).to include('User First')
      expect(user_all).to include('User Last')
    end
  end
end
