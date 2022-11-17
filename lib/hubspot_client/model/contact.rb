# frozen_string_literal: true

module HubspotClient
  module Model
    class MissingParameter < StandardError; end

    class Contact < OpenStruct
      UPDATABLE_ATTRIBUTES = %i[firstname lastname email].freeze

      def self.find(email: nil, hubspot_id: nil)
        response = if email
                     ContactClient.new.find_by_email(email)
                   elsif hubspot_id
                     ContactClient.new.find_by_id(hubspot_id)
                   else
                     raise MissingParameter, 'email or hubspot_id needs to be set'
                   end

        new(response['properties'])
      end

      def self.create(properties)
        sliced_properties = properties.slice(*UPDATABLE_ATTRIBUTES)
        response = ContactClient.new.create(sliced_properties)

        new(response['properties'])
      end

      def update
        properties = to_h.slice(*UPDATABLE_ATTRIBUTES)
        response = ContactClient.new.update(hs_object_id, properties)

        return true if response.code == 200

        false
      end

      def reload
        response = ContactClient.new.find_by_id(hs_object_id)
        response['properties'].each do |key, value|
          self[key] = value if value != self[key]
        end

        self
      end
    end
  end
end
