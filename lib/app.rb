# frozen_string_literal: true

require_relative "./db"
require 'json'
require "roda"

class App < Roda
  route do |r|
    @db = DB.new

    r.root do
      "Hello, World!"
    end

    r.on "accounts" do
      r.is do
        r.get do
          { accounts: @db.accounts }.to_json
        end

        r.post do
          response.status = 201
          address = r['address']
          response = AccountManager.new(@db).create!(address)
          response.to_json
        end
      end
    end
  end
end
