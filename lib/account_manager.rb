# frozen_string_literal: true

require 'httparty'
require_relative './db'

class AccountManager
  def initialize(db)
    @db = db
  end

  def create!(address)
    balance = retrieve_balance_weis(address)
    @db.create_account(address, balance)
  end

  API_BASE = "https://etherchain.org/api/account/"
  def retrieve_balance_weis(address)
    response = HTTParty.get(API_BASE + address)
    account_details = response["data"].find do |account_details|
      account_details['address'] == address
    end
    account_details['balance']
  end
end
