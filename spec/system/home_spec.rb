require 'spec_helper'

RSpec.describe 'View app home' do
  it 'successfully' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq('Home Frank Calendar! =)')
  end
end
