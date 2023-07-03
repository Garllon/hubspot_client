# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start do
  add_filter 'spec'
end

require 'hubspot_client'

require 'dotenv'
require 'pry'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<BEARER_TOKEN>') do |interaction|
    auths = interaction.request.headers['Authorization'].first
    if (match = auths.match(/^Bearer\s+([^,\s]+)/))
      match.captures.first
    end
  end

  config.filter_sensitive_data('<FORM_STRING_ID>') do |interaction|
    hubspot_form_url = HubspotClient::Client::Form.base_uri + HubspotClient::Client::Form::BASE_PATH_V3

    if interaction.request.uri.start_with?(hubspot_form_url)
      body = JSON.parse(interaction.response.body)
      body&.[]('results')&.first&.[]('id')
    end
  end
end

Dotenv.load

RSpec.configure do |config|
  config.warnings = true
  config.order = :random
end

HubspotClient.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
end
