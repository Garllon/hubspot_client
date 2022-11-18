module HubspotClient
  module Client
    class CompanyNotFound < StandardError; end
    class CompanyNotCreated < StandardError; end
    class CompanyNotUpdated < StandardError; end

    class Company
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH = "/crm/v3/objects/comapnies"
      FIND_PROPERTIES = %w(name phone address city zip).freeze

      def find_by_id(hubspot_id)
        response = self.class.get("#{BASE_PATH}/#{hubspot_id}", headers: headers)
        return response if response.code == 200

        raise CompanyNotFound, 'Hubspot Company Not Found'
      end

      def create(properties)
        response = self.class.post(BASE_PATH,
                                   body: { properties: properties }.to_json,
                                   headers: headers)

        return response if response.code == 201

        raise CompanyNotCreated, 'Hubspot could not Create'
      end

      def update(hubspot_id, properties)
        response = self.class.patch("#{BASE_PATH}/#{hubspot_id}",
                                    body: { properties: properties }.to_json,
                                    headers: headers)

        return response if response.code == 200

        raise CompanyNotUpdated, 'Hubspot could not update'
      end

      private

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end