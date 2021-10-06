require './app'
require 'rspec'
require 'rack/test'

RSpec.describe 'View app home' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'successfully' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq('Home Frank Calendar! =)')
  end
end
