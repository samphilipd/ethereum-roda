# frozen_string_literal: true

require 'vcr'
require 'rspec'
require 'rack/test'

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path("fixtures/vcr_cassettes", File.dirname(__FILE__))
  config.hook_into :webmock
end
