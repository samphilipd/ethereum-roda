# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/account_manager'

RSpec.describe AccountManager do
  let(:address) { "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad" }
  let(:db) { DB.new }

  describe '#create!' do
    it 'creates an account' do
      expect do
        VCR.use_cassette("balance/#{address}") do
          expect(
            described_class.new(db).create!(address)
          ).to eq(
            account_address: "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad",
            balance_wei: 1989580000000000000
          )
        end
      end.to change { db.accounts.size }.from(0).to(1)
    end
  end

  describe '#retrieve_balance_weis' do
    it 'gets balance for account' do
      VCR.use_cassette("balance/#{address}") do
        expect(described_class.new(db).retrieve_balance_weis(address)).to eq(1989580000000000000)
      end
    end
  end
end
