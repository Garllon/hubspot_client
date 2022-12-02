# frozen_string_literal: true

require 'httparty'
require 'hubspot_client/client_base_error'
require 'hubspot_client/client/communication_preference'
require 'hubspot_client/client/company'
require 'hubspot_client/client/contact'
require 'hubspot_client/client/properties'
require 'hubspot_client/configuration'
require 'hubspot_client/model/communication_preference'
require 'hubspot_client/model/company'
require 'hubspot_client/model/contact'
require 'hubspot_client/version'

module HubspotClient
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration.reset!
  end

  def self.configure
    yield(configuration)
  end
end
