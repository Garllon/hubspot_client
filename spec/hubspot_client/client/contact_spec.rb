# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::Client::Contact do
  after do
    VCR.eject_cassette
  end

  describe '#find_by_email' do
    subject(:response) { described_class.new.find_by_email('tester@example.com') }

    before do
      VCR.insert_cassette 'client/contact/find_by_email'
    end

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
    subject(:response) { described_class.new.find_by_id('34351') }

    before do
      VCR.insert_cassette 'client/contact/find_by_id'
    end

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
    subject(:response) { described_class.new.create(properties) }

    before do
      VCR.insert_cassette 'client/contact/create'
    end

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
    subject(:response) { described_class.new.update('34301', properties) }

    before do
      VCR.insert_cassette 'client/contact/update'
    end

    let(:properties) { { firstname: 'Blubber' } }

    it 'returns status code 200' do
      expect(response.code).to be 200
    end

    it 'updates the firstname' do
      expect(response['properties']['firstname']).to eq 'Blubber'
    end
  end
end
