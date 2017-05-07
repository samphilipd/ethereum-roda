# frozen_string_literal: true

require 'sequel'
require 'sqlite3'

class DB
  def initialize
    @sqlite = Sequel.sqlite # in-memory database
    create_tables
  end

  def accounts
    accounts = @sqlite[:accounts].to_a
    accounts.each do |account|
      account[:balance_ethers] = wei_to_ether(account[:balance_wei])
    end
    accounts
  end

  def create_account(address, balance)
    record = { account_address: address, balance_wei: balance }
    @sqlite[:accounts].insert(record)
    record
  end

  private

  def create_tables
    @sqlite.create_table :accounts do
      primary_key :id
      String :account_address
      Integer :balance_wei
    end
  end

  WEI_IN_ETHER = 1000000000000000000
  def wei_to_ether(wei)
    wei.to_f / WEI_IN_ETHER
  end
end
