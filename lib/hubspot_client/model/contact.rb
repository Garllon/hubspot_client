# frozen_string_literal: true

module HubspotClient
  module Model
    class MissingParameter < StandardError; end

    class Contact < OpenStruct
      UPDATABLE_PROPERTIES = %i[firstname lastname email phone lifecyclestage].freeze

      def self.find(hubspot_id: nil, email: nil)
        response = if hubspot_id
                     ContactClient.new.find_by_id(hubspot_id)
                   elsif email
                     ContactClient.new.find_by_email(email)
                   else
                     raise MissingParameter, 'email or hubspot_id needs to be set'
                   end

        new(response['properties'])
      end

      def self.create(properties)
        sliced_properties = properties.slice(*UPDATABLE_PROPERTIES)
        response = ContactClient.new.create(sliced_properties)

        new(response['properties'])
      end

      def update
        properties = to_h.slice(*UPDATABLE_PROPERTIES)
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
