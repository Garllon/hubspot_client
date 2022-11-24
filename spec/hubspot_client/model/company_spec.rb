# frozen_string_literal: true

require 'spec_helper'

module HubspotClient
  RSpec.shared_examples 'find company' do |properties|
    properties.each do |property, value|
      it "creates an company object with correct #{property}" do
        expect(company.public_send(property)).to eq value
      end
    end
  end

  describe Model::Company do
    let(:client_company) { instance_double(Client::Company) }

    before do
      allow(Client::Company).to receive(:new).and_return(client_company)
    end

    describe '.find' do
      context 'when hubspot_id parameter is given' do
        before do
          allow(client_company)
            .to receive(:find_by_id)
            .and_return({ 'properties' => properties })
        end

        properties_values = {
          name: 'Todesstern Verwaltungs GmbH',
          phone: '012523456789',
          address: 'Plapatine Straße 23',
          city: 'Berlin',
          zip: '12634'
        }

        let(:hubspot_id) { '1337' }
        let(:properties) { properties_values }

        subject(:company) { described_class.find(hubspot_id: hubspot_id) }

        include_examples 'find company', properties_values
      end
    end

    describe '.create' do
      before do
        allow(client_company)
          .to receive(:create)
          .and_return({ 'properties' => properties })
      end

      properties_values = {
        name: 'Todesstern Verwaltungs GmbH',
        phone: '012523456789',
        address: 'Plapatine Straße 23',
        city: 'Berlin',
        zip: '12634'
      }

      let(:properties) { updatable_properties.merge(not_updatable_properties) }
      let(:updatable_properties) { properties_values }
      let(:not_updatable_properties) { { random_not_mutable_propertie: 'Anakin' } }

      subject(:company) { described_class.create(properties) }

      include_examples 'find company', properties_values

      it 'excludes not_updatable_properties' do
        company

        expect(client_company).to have_received(:create).with(hash_excluding(not_updatable_properties))
      end

      it 'only use updatable properties' do
        company

        expect(client_company).to have_received(:create).with(updatable_properties)
      end
    end

    describe '#update' do
      before do
        allow(client_company)
          .to receive(:update)
          .and_return(instance_double(HTTParty::Response, body: { 'properties' => properties }, code: 200))
      end

      properties_values = {
        name: 'Todesstern Verwaltungs GmbH',
        phone: '012523456789',
        address: 'Plapatine Straße 23',
        city: 'Berlin',
        zip: '12634'
      }

      let(:properties) { updatable_properties.merge(not_updatable_properties) }
      let(:updatable_properties) { properties_values }
      let(:not_updatable_properties) { { random_not_mutable_propertie: 'Anakin' } }

      subject(:company) { described_class.new(properties.merge({ hs_object_id: '1337' })).update }

      it 'returns true' do
        expect(company).to eq true
      end
    end
  end
end
