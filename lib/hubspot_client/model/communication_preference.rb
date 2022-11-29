# frozen_string_literal: true

module HubspotClient
  module Model
    class CommunicationPreference
      def self.all
        Client::CommunicationPreference.new.definitions
      end
    end
  end
end
