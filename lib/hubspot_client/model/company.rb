# frozen_string_literal: true

module HubspotClient
  module Model
    class Company < OpenStruct
      UPDATABLE_PROPERTIES = %i[name phone address city zip].freeze

      def self.find(hubspot_id: nil)
        response = Client::Company.new.find_by_id(hubspot_id)

        return nil if response['properties'].nil?

        new(response['properties'])
      end

      def self.create(properties)
        sliced_properties = properties.slice(*UPDATABLE_PROPERTIES)
        response = Client::Company.new.create(sliced_properties)

        new(response['properties'])
      end

      def update
        properties = to_h.slice(*UPDATABLE_PROPERTIES)
        response = Client::Company.new.update(hs_object_id, properties)

        return true if response.code == 200

        false
      end

      def reload
        response = Client::Company.new.find_by_id(hs_object_id)
        response['properties'].each do |key, value|
          self[key] = value if value != self[key]
        end

        self
      end
    end
  end
end
