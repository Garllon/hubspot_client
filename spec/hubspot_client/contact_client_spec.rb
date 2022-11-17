# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::ContactClient do
  describe '#find_by_email' do
    it 'returns status code 200' do
      VCR.use_cassette("contact_client/find_by_email") do
        response = described_class.new.find_by_email('tester@example.com')
        expect(response.code).to be 200
      end
    end

    it 'returns the correct properties' do
      VCR.use_cassette("contact_client/find_by_email") do
        response = described_class.new.find_by_email('tester@example.com')
        expect(response['properties']['firstname']).to eq 'Tester'
      end
    end
  end
end