# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::Client::Company do
  after do
    VCR.eject_cassette
  end

  describe '#find_by_id' do
    subject(:response) { described_class.new.find_by_id('6559302888') }

    before do
      VCR.insert_cassette 'client/company/find_by_íd'
    end

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    properties_values = {
      name: 'Blubber Test GmbH',
      phone: '0151348235894895',
      address: 'Blubber Straße 23',
      city: 'Berlin',
      zip: '10147'
    }

    properties_values.each do |property, value|
      it "returns the correct #{property}" do
        expect(response['properties'][property.to_s]).to eq value
      end
    end
  end

  describe '#create' do
    subject(:response) { described_class.new.create(properties) }

    before do
      VCR.insert_cassette 'client/company/create'
    end

    properties_values = {
      name: 'Todesstern Verwaltungs GmbH',
      phone: '012523456789',
      address: 'Plapatine Straße 23',
      city: 'Berlin',
      zip: '12634'
    }

    let(:properties) { properties_values }

    it 'returns status code 201' do
      expect(response.code).to be 201
    end

    properties_values.each do |property, value|
      it "create with #{property}" do
        expect(response['properties'][property.to_s]).to eq value
      end
    end
  end

  describe '#update' do
    subject(:response) { described_class.new.update(hubspot_id, properties) }

    before do
      VCR.insert_cassette 'client/company/update'
    end

    properties_values = {
      name: 'Todesstern Verwaltungs GmbH',
      phone: '012523456789',
      address: 'Plapatine Straße 23',
      city: 'Berlin',
      zip: '12634'
    }

    let(:hubspot_id) { '6564551665' }
    let(:properties) { properties_values }

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    properties_values.each do |property, value|
      it "create with #{property}" do
        expect(response['properties'][property.to_s]).to eq value
      end
    end
  end
end
