# frozen_string_literal: true

module HubspotClient
  module Model
    class MissingParameter < StandardError; end

    class Contact < OpenStruct
      UPDATABLE_PROPERTIES = %i[firstname lastname email phone lifecyclestage].freeze

      def self.find(hubspot_id: nil, email: nil)
        response = if hubspot_id
                     Client::Contact.new.find_by_id(hubspot_id)
                   elsif email
                     Client::Contact.new.find_by_email(email)
                   else
                     raise MissingParameter, 'email or hubspot_id needs to be set'
                   end

        new(response['properties'])
      end

      def self.create(properties)
        sliced_properties = properties.slice(*UPDATABLE_PROPERTIES)
        response = Client::Contact.new.create(sliced_properties)

        new(response['properties'])
      end

      def update
        properties = to_h.slice(*UPDATABLE_PROPERTIES)
        response = Client::Contact.new.update(hs_object_id, properties)

        return true if response.code == 200

        false
      end

      def reload
        response = Client::Contact.new.find_by_id(hs_object_id)
        response['properties'].each do |key, value|
          self[key] = value if value != self[key]
        end

        self
      end

      def create_communication_subscription(subscription_id:, legal_basis: nil, legal_basis_explanation: nil)
        properties = {
          emailAddress: email,
          subscriptionId: subscription_id,
          legalBasis: legal_basis,
          legalBasisExplanation: legal_basis_explanation
        }

        Client::CommunicationPreference.new.subscribe(properties)
      end

      def primary_company
        @primary_company ||= Company.find(hubspot_id: associatedcompanyid)
      end
    end
  end
end
