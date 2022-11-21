# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::Client::Company do
  after do
    VCR.eject_cassette
  end

  describe '#find_by_id' do
    before do
      VCR.insert_cassette 'client/company/find_by_íd'
    end

    subject(:response) { described_class.new.find_by_id('6559302888') }

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
      it 'returns the correct name' do
        expect(response['properties'][property.to_s]).to eq value
      end
    end
  end
end
