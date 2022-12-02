# frozen_string_literal: true

module HubspotClient
  module Model
    class Company < OpenStruct
      def self.find(hubspot_id: nil)
        response = Client::Company.new.find_by_id(hubspot_id)

        return nil if response['properties'].nil?

        new(response['properties'])
      end

      def self.create(properties)
        response = Client::Company.new.create(properties)

        new(response['properties'])
      end

      def update(new_properties = {})
        assign_attributes(new_properties)
        response = Client::Company.new.update(hs_object_id, to_h)

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

      def assign_attributes(attributes)
        attributes.each do |attribute, value|
          self[attribute] = value
        end
      end
    end
  end
end
