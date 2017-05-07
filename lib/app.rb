# frozen_string_literal: true

require_relative "./db"
require_relative "./account_manager"
require 'json'
require "roda"

class App < Roda
  plugin :json
  plugin :json_parser

  APP_DB = DB.new

  route do |r|
    r.root do
      "Hello, World!"
    end

    r.on "accounts" do
      r.is do
        # GET /accounts
        r.get do
          { accounts: APP_DB.accounts }
        end

        # POST /accounts?address=ADDRESS
        r.post do
          response.status = 201
          address = r.params['address']
          response = AccountManager.new(APP_DB).create!(address)
          response
        end
      end
    end
  end
end
