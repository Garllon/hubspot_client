# frozen_string_literal: true

require 'spec_helper'

module HubspotClient
  describe Model::Contact do
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
      context 'when email parameter is given' do
        before do
          allow(client_contact)
            .to receive(:find_by_email)
            .and_return({ 'properties' => { firstname: firstname, lastname: lastname, email: email } })
        end

        subject(:contact) { described_class.find(email: email) }

        include_examples 'find contact'
      end

      context 'when hubspot_id parameter is given' do
        before do
          allow(client_contact)
            .to receive(:find_by_id)
            .and_return({ 'properties' => { firstname: firstname, lastname: lastname, email: email } })
        end

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

      let(:properties) { updatable_properties.merge(not_updatable_properties) }
      let(:updatable_properties) { { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@example.com' } }
      let(:not_updatable_properties) { { random_not_mutable_propertie: 'Anakin' } }

      include_examples 'find contact'

      it 'excludes not_updatable_properties' do
        contact

        expect(client_contact).to have_received(:create).with(hash_excluding(not_updatable_properties))
      end

      it 'only use updatable properties' do
        contact

        expect(client_contact).to have_received(:create).with(updatable_properties)
      end
    end
  end
end
