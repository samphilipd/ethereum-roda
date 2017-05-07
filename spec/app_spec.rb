# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/app'

RSpec.describe App do
  include Rack::Test::Methods

  let(:address) { "0x8eeec35015baba2890e714e052dfbe73f4b752f9" }

  def app
    described_class
  end

  before(:each) do # reset DB every time
    described_class::APP_DB.instance_variable_get(:@sqlite)[:accounts].truncate
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello, World!')
  end

  it 'gets the list of accounts' do
    get '/accounts'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("{\"accounts\":[]}")
  end

  it 'posts a new account' do
    VCR.use_cassette("balance/#{address}") do
      post "/accounts?address=#{address}"
    end

    expect(last_response).to be_created
    expect(JSON.parse(last_response.body)).to eq({"account_address" => "0x8eeec35015baba2890e714e052dfbe73f4b752f9", "balance_wei" => 1200000000000000000})
  end

  it 'posts a new account then lists it' do
    VCR.use_cassette("balance/#{address}") do
      post "/accounts?address=#{address}"
    end

    get '/accounts'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({"accounts" => [{"id"=>2, "account_address"=>"0x8eeec35015baba2890e714e052dfbe73f4b752f9", "balance_wei"=>1200000000000000000, "balance_ethers"=>1.2}]})
  end
end
