# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::Client::CommunicationPreference do
  after do
    VCR.eject_cassette
  end

  describe '#definitions' do
    subject(:response) { described_class.new.definitions }

    before do
      VCR.insert_cassette 'client/communication_preference/definitions'
    end

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    it 'includes communication preference definitions' do
      expect(response['subscriptionDefinitions'].count).to be > 0
    end

    it 'includes id in definitions' do
      expect(response['subscriptionDefinitions'].first['id']).to be_kind_of(String)
    end
  end

  describe '#subscribe' do
    subject(:response) do
      described_class.new.subscribe(
        emailAddress: 'darth.vader@farbfox.de',
        subscriptionId: '141824865',
        legalBasis: 'CONSENT_WITH_NOTICE',
        legalBasisExplanation: 'this is an explanation'
      )
    end

    before do
      VCR.insert_cassette 'client/communication_preference/subscribe'
    end

    it 'returns status code 200' do
      expect(response.code).to be 200
    end
  end
end
