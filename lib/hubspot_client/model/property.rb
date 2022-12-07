# frozen_string_literal: true

module HubspotClient
  module Service
    class Model
      def self.writable_property_names_for(object_type)
        readonly_properties = self.for(object_type)['results'].reject do |property|
          property['modificationMetadata']['readOnlyValue'] == true
        end

        readonly_properties.map { |property| property['name'].to_sym }
      end

      def self.for(object_type)
        HubspotClient::Client::Properties.new.for(object_type)
      end
    end
  end
end
