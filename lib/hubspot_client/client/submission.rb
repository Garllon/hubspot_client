# frozen_string_literal: true

module HubspotClient
  module Client
    class Submission
      include HTTParty
      base_uri 'https://api.hsforms.com'

      BASE_PATH_V3 = '/submissions/v3/integration/secure/submit'

      def initialize(portal_id:, form_guid:, fields: [])
        @portal_id = portal_id
        @form_guid = form_guid
        @fields    = fields
      end

      def submit
        url = "#{BASE_PATH_V3}/#{@portal_id}/#{@form_guid}"
        self.class.post(url, body: body.to_json, headers: headers)
      end

      private

      def body
        {
          "fields": @fields
        }
      end

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
