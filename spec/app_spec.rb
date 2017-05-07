require 'rspec'
require 'rack/test'
require_relative '../lib/app'

describe App do
  include Rack::Test::Methods

  def app
    described_class
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello, World!')
  end
end
