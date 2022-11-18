# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::ContactClient do
  after do
    VCR.eject_cassette
  end

  describe '#find_by_email' do
    before do
      VCR.insert_cassette 'contact_client/find_by_email'
    end

    subject(:response) { described_class.new.find_by_email('tester@example.com') }

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    it 'returns the correct firstname' do
      expect(response['properties']['firstname']).to eq 'Tester'
    end

    it 'returns the correct lastname' do
      expect(response['properties']['lastname']).to eq 'Testi'
    end

    it 'returns the correct phonenumber' do
      expect(response['properties']['phone']).to eq '+4915212345678'
    end

    it 'returns the correct lifecycle stage' do
      expect(response['properties']['lifecyclestage']).to eq 'lead'
    end
  end

  describe '#find_by_id' do
    before do
      VCR.insert_cassette 'contact_client/find_by_id'
    end

    subject(:response) { described_class.new.find_by_id(34351) }

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    it 'returns the correct firstname' do
      expect(response['properties']['firstname']).to eq 'Tester'
    end

    it 'returns the correct lastname' do
      expect(response['properties']['lastname']).to eq 'Testi'
    end

    it 'returns the correct phonenumber' do
      expect(response['properties']['phone']).to eq '+4915212345678'
    end

    it 'returns the correct lifecycle stage' do
      expect(response['properties']['lifecyclestage']).to eq 'lead'
    end
  end

  describe '#create' do
    before do
      VCR.insert_cassette 'contact_client/create'
    end

    subject(:response) { described_class.new.create(properties) }

    let(:properties) { { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@farbfox.de' } }

    it 'returns status code 201' do
      expect(response.code).to be 201
    end

    it 'create with firstname' do
      expect(response['properties']['firstname']).to eq 'Darth'
    end

    it 'create with lastname' do
      expect(response['properties']['lastname']).to eq 'Vader'
    end

    it 'create with email' do
      expect(response['properties']['email']).to eq 'darth.vader@farbfox.de'
    end
  end

  describe '#update' do
    before do
      VCR.insert_cassette 'contact_client/update'
    end

    subject(:response) { described_class.new.update(34301, properties) }

    let(:properties) { { firstname: 'Blubber' } }

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    it 'updates the firstname' do
      expect(response['properties']['firstname']).to eq 'Blubber'
    end
  end
end