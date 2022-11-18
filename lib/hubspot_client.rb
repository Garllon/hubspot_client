# frozen_string_literal: true

require 'httparty'
require 'hubspot_client/version'
require 'hubspot_client/configuration'
require 'hubspot_client/client/contact'
require 'hubspot_client/client/company'
require 'hubspot_client/model/contact'

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
