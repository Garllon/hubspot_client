# frozen_string_literal: true

module HubspotClient
  module Client
    class Submission
      include HTTParty
      base_uri 'https://api.hsforms.com'

      BASE_PATH_V3 = '/submissions/v3/integration/secure/submit'

      # EXAMPLES:
      # fields: [{name: 'email', value: 'darth_garllon@example.com'}]
      #
      # context: {
      #   pageUri: "https://example.com",
      #   pageName: "Example page"
      # }
      #
      # legal_consent_options: {
      #   consent: {
      #     consentToProcess: true,
      #     text: "I agree to allow #{company_name} to store and process my personal data.",
      #     communications: []
      #   }
      # }

      def initialize(portal_id:, form_guid:, fields: [], context: {}, legal_consent_options: {})
        @portal_id             = portal_id
        @form_guid             = form_guid
        @fields                = fields
        @context               = context
        @legal_consent_options = legal_consent_options
      end

      def submit
        url = "#{BASE_PATH_V3}/#{@portal_id}/#{@form_guid}"
        self.class.post(url, body: body.to_json, headers: headers)
      end

      private

      def body
        {
          fields: @fields,
          context: @context,
          legalConsentOptions: @legal_consent_options
        }
      end

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
