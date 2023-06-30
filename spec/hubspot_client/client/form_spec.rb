# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::Client::Form do
  after do
    VCR.eject_cassette
  end

  describe '.all_forms' do
    subject(:response) { described_class.all_forms }

    before do
      VCR.insert_cassette 'client/form/all_forms'
    end

    it 'returns status code 200' do
      expect(response.code).to be 200
    end
  end
end
