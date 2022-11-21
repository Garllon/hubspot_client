# frozen_string_literal: true

module HubspotClient
  module Client
    class Properties
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH = '/crm/v3/properties'

      def for(object_type)
        response = self.class.get("#{BASE_PATH}/#{object_type}", headers: headers)
        return response if response.code == 200
      end

      private

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
