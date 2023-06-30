# frozen_string_literal: true

module HubspotClient
  module Client
    class Form
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH_V3 = '/marketing/v3/forms/'

      def self.all_forms(limit: 20)
        url = "#{BASE_PATH_V3}?limit=#{limit}"
        get(url, headers: headers)
      end

      def self.headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
