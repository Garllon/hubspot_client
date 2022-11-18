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

    describe '.find' do
      context 'email parameter is given' do
        before do
          allow_any_instance_of(Client::Contact)
            .to receive(:find_by_email)
            .and_return({ 'properties' => { firstname: firstname, lastname: lastname, email: email } })
        end

        subject(:contact) { described_class.find(email: email) }

        include_examples 'find contact'
      end

      context 'hubspot_id parameter is given' do
        before do
          allow_any_instance_of(Client::Contact)
            .to receive(:find_by_id)
            .and_return({ 'properties' => { firstname: firstname, lastname: lastname, email: email } })
        end

        subject(:contact) { described_class.find(hubspot_id: '1337') }

        include_examples 'find contact'
      end
    end

    describe '.create' do
      before do
        allow_any_instance_of(Client::Contact)
          .to receive(:create)
          .and_return({ 'properties' => properties })
      end

      subject(:contact) { described_class.create(properties) }

      let(:firstname) { 'Darth' }
      let(:lastname) { 'Vader' }
      let(:email) { 'darth.vader@example.com' }
      let(:properties) { updatable_properties.merge(not_updatable_properties) }
      let(:updatable_properties) { { firstname: firstname, lastname: lastname, email: email } }
      let(:not_updatable_properties) { { random_not_mutable_propertie: 'Anakin' } }

      include_examples 'find contact'

      it 'excludes not_updatable_properties' do
        expect_any_instance_of(Client::Contact).to receive(:create).with(hash_excluding(not_updatable_properties))

        contact
      end

      it 'only use updatable properties' do
        expect_any_instance_of(Client::Contact).to receive(:create).with(updatable_properties)

        contact
      end
    end
  end
end
