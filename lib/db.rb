# frozen_string_literal: true

require 'sequel'
require 'sqlite3'

class DB
  def initialize
    @sqlite = Sequel.sqlite # in-memory database
    create_tables
    populate_data
  end

  def accounts
    @sqlite[:accounts].to_a
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

  def populate_data
    # pass
  end
end
