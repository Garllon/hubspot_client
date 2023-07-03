# frozen_string_literal: true

require 'spec_helper'
require_relative '../shared/with_properties_stub'

module HubspotClient
  describe Model::Contact do
    include_context 'with properties stub'

    RSpec.shared_examples 'find contact' do
      let(:firstname) { 'Darth' }
      let(:lastname) { 'Vader' }
      let(:email) { 'darth.vader@example.com' }

      it 'creates an contact object with correct firstname' do
        expect(contact.firstname).to eq firstname
      end

      it 'creates an contact object with correct lastname' do
        expect(contact.lastname).to eq lastname
      end

      it 'creates an contact object with correct email' do
        expect(contact.email).to eq email
      end
    end

    let(:client_contact) { instance_double(Client::Contact) }

    before do
      allow(Client::Contact).to receive(:new).and_return(client_contact)
    end

    describe '.find' do
      before do
        allow(client_contact)
          .to receive(method)
          .and_return({ 'properties' => properties })
      end

      let(:properties) { { firstname: firstname, lastname: lastname, email: email } }

      context 'when email parameter is given' do
        let(:method) { 'find_by_email' }

        subject(:contact) { described_class.find(email: email) }

        include_examples 'find contact'
      end

      context 'when hubspot_id parameter is given' do
        let(:method) { 'find_by_id' }

        subject(:contact) { described_class.find(hubspot_id: '1337') }

        include_examples 'find contact'
      end
    end

    describe '.create' do
      subject(:contact) { described_class.create(properties) }

      before do
        allow(client_contact)
          .to receive(:create)
          .and_return({ 'properties' => properties })
      end

      let(:properties) { { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@example.com' } }

      include_examples 'find contact'

      it 'updates the properties' do
        contact

        expect(client_contact).to have_received(:create).with(properties)
      end
    end

    describe '#update' do
      before do
        allow(client_contact)
          .to receive(:update)
          .and_return(instance_double(HTTParty::Response, body: { 'properties' => properties }, code: 200))
      end

      let(:properties) { { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@example.com' } }

      context 'without empty parameters' do
        subject(:contact) { described_class.new(properties.merge({ hs_object_id: '1337' })).update }

        it 'returns true' do
          expect(contact).to eq true
        end
      end

      context 'with parameters' do
        subject(:contact) { described_class.new({ hs_object_id: '1337' }).update(properties) }

        it 'returns true' do
          expect(contact).to eq true
        end
      end
    end

    describe '.create_communication_subscription' do
      subject(:contact) { described_class.new(email: 'darth.vader@example.com') }

      let(:client_communication_preference) { instance_double(Client::CommunicationPreference) }

      before do
        allow(Client::CommunicationPreference).to receive(:new).and_return(client_communication_preference)
        allow(client_communication_preference).to receive(:subscribe)
      end

      expected_properties = {
        emailAddress: 'darth.vader@example.com',
        subscriptionId: 'subscription_id_value',
        legalBasis: 'legal_basis_value',
        legalBasisExplanation: 'legal_basis_explanation_value'
      }

      it 'creates a subscription' do
        contact.create_communication_subscription(subscription_id: 'subscription_id_value',
                                                  legal_basis: 'legal_basis_value',
                                                  legal_basis_explanation: 'legal_basis_explanation_value')

        expect(client_communication_preference).to have_received(:subscribe).with(expected_properties)
      end
    end
  end
end
