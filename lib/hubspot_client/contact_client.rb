# frozen_string_literal: true

module HubspotClient
  class ContactNotFound < StandardError; end
  class ContactNotUpdated < StandardError; end

  class ContactClient
    include HTTParty
    base_uri 'https://api.hubapi.com'

    BASE_PATH = "/crm/v3/objects/contacts"
    FIND_PROPERTIES = %w(firstname lastname email phone lifecyclestage associatedcompanyid).freeze

    def find_by_email(email)
      query_params = find_query_params({idProperty: 'email'})
      find_by("#{BASE_PATH}/#{email}?#{query_params}")
    end

    def find_by_id(hubspot_id)
      query_params = find_query_params

      find_by("#{BASE_PATH}/#{hubspot_id}?#{query_params}")
    end

    def create(properties)
      response = self.class.post(BASE_PATH,
                                 body: { properties: properties }.to_json,
                                 headers: headers)

      return response if response.code == 201

      raise ContactNotFound, 'Hubspot Contact Not Found'
    end

    def update(hubspot_id, properties)
      response = self.class.patch("#{BASE_PATH}/#{hubspot_id}",
                                  body: { properties: properties }.to_json,
                                  headers: headers)

      return response if response.code == 200

      raise ContactNotUpdated, 'Hubspot could not update'
    end

    private

    def find_by(path)
      response = self.class.get(path, headers: headers)
      return response if response.code == 200

      raise ContactNotFound, 'Hubspot Contact Not Found'
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
