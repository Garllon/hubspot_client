# frozen_string_literal: true

module HubspotClient
  module Client
    class ContactNotFound < ClientBaseError; end
    class ContactNotCreated < ClientBaseError; end
    class ContactNotUpdated < ClientBaseError; end
    class AssociationError < ClientBaseError; end

    class Contact
      include HTTParty
      base_uri 'https://api.hubapi.com'

      BASE_PATH_V3 = '/crm/v3/objects/contacts'
      FIND_PROPERTIES = %w[firstname lastname email phone lifecyclestage associatedcompanyid].freeze

      def find_by_email(email)
        query_params = find_query_params({ idProperty: 'email' })
        find_by("#{BASE_PATH_V3}/#{email}?#{query_params}")
      end

      def find_by_id(hubspot_id)
        query_params = find_query_params

        find_by("#{BASE_PATH_V3}/#{hubspot_id}?#{query_params}")
      end

      def create(properties)
        response = self.class.post(BASE_PATH_V3,
                                   body: { properties: properties }.to_json,
                                   headers: headers)

        return response if response.code == 201

        raise ContactNotCreated, response
      end

      def update(hubspot_id, properties)
        response = self.class.patch("#{BASE_PATH_V3}/#{hubspot_id}",
                                    body: { properties: properties }.to_json,
                                    headers: headers)

        return response if response.code == 200

        raise ContactNotUpdated, response
      end

      def associate_with(hubspot_id, to_object_type, to_object_type_id, association_type = '1')
        path = "#{BASE_PATH_V3}/#{hubspot_id}/associations/#{to_object_type}/#{to_object_type_id}/#{association_type}"
        response = self.class.put(path, headers: headers)

        return response if response.code == 200

        raise AssociationError, response
      end

      private

      def find_by(path)
        response = self.class.get(path, headers: headers)
        return response if response.code == 200

        raise ContactNotFound, response
      end

      def find_query_params(query_params = {})
        query_params['properties'] = FIND_PROPERTIES.join(',')
        query_params.map do |key, value|
          "#{key}=#{value}"
        end.join('&')
      end

      def headers
        { Authorization: "Bearer #{HubspotClient.configuration.access_token}",
          'Content-Type': 'application/json' }
      end
    end
  end
end
