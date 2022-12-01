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
    subject(:create) { described_class.new.create(properties) }

    context 'when it is successful' do
      before do
        VCR.insert_cassette 'client/contact/create/success'
      end

      property_values = { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@farbfox.de' }

      let(:properties) { property_values }

      it 'returns status code 201' do
        expect(create.code).to be 201
      end

      property_values.each do |key, value|
        it "create with #{key}" do
          expect(create['properties'][key.to_s]).to eq value
        end
      end
    end

    context 'when it returns an error' do
      before do
        VCR.insert_cassette 'client/contact/create/error'
      end

      let(:properties) { { email: 'invalid' } }

      it 'returns status code 400' do
        expect { create }.to raise_error(HubspotClient::Client::ContactNotCreated)
      end
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
