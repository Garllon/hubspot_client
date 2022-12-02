# frozen_string_literal: true

module HubspotClient
  module Client
    class CompanyNotFound < ClientBaseError; end
    class CompanyNotCreated < ClientBaseError; end
    class CompanyNotUpdated < ClientBaseError; end

    class Company
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH = '/crm/v3/objects/companies'
      FIND_PROPERTIES = %w[name phone address city zip].freeze

      def find_by_id(hubspot_id)
        response = self.class.get("#{BASE_PATH}/#{hubspot_id}?properties=#{FIND_PROPERTIES.join(',')}",
                                  headers: headers)
        return response if response.code == 200

        raise CompanyNotFound, response
      end

      def create(properties)
        response = self.class.post(BASE_PATH,
                                   body: { properties: properties }.to_json,
                                   headers: headers)

        return response if response.code == 201

        raise CompanyNotCreated, response
      end

      def update(hubspot_id, properties)
        response = self.class.patch("#{BASE_PATH}/#{hubspot_id}",
                                    body: { properties: properties }.to_json,
                                    headers: headers)

        return response if response.code == 200

        raise CompanyNotUpdated, response
      end

      private

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
