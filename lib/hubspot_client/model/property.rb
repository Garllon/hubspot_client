# frozen_string_literal: true

module HubspotClient
  module Model
    class Property
      def self.all_for(object_type)
        HubspotClient::Client::Properties.new.for(object_type)
      end

      def self.writable_property_names_for(object_type)
        readonly_properties = all_for(object_type)['results'].reject do |property|
          property['modificationMetadata']['readOnlyValue'] == true
        end

        readonly_properties.map { |property| property['name'].to_sym }
      end
    end
  end
end
