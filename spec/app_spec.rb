# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/app'

RSpec.describe App do
  include Rack::Test::Methods

  let(:address) { "0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c" }

  def app
    described_class
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
    expect(last_response.body).to eq("{\"account_address\":\"0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c\",\"balance_wei\":0}")
  end

  it 'posts a new account then lists it' do
    VCR.use_cassette("balance/#{address}") do
      post "/accounts?address=#{address}"
    end

    get '/accounts'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq({"accounts" => [{"id"=>1, "account_address"=>"0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c", "balance_wei"=>0, "balance_ethers"=>0.0}, {"id"=>2, "account_address"=>"0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c", "balance_wei"=>0, "balance_ethers"=>0.0}]})
  end
end
