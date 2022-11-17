# frozen_string_literal: true

require 'spec_helper'

describe HubspotClient::ContactClient do
  describe '#find_by_email' do
    subject(:response) { described_class.new.find_by_email('tester@example.com') }

    it 'returns status code 200' do
      VCR.use_cassette("contact_client/find_by_email") do
        expect(response.code).to be 200
      end
    end

    it 'returns the correct firstname' do
      VCR.use_cassette("contact_client/find_by_email") do
        expect(response['properties']['firstname']).to eq 'Tester'
      end
    end

    it 'returns the correct lastname' do
      VCR.use_cassette("contact_client/find_by_email") do
        expect(response['properties']['lastname']).to eq 'Testi'
      end
    end
  end

  describe '#find_by_id' do
    subject(:response) { described_class.new.find_by_id(34351) }

    it 'returns status code 200' do
      VCR.use_cassette("contact_client/find_by_id") do
        expect(response.code).to be 200
      end
    end

    it 'returns the correct firstname' do
      VCR.use_cassette("contact_client/find_by_id") do
        expect(response['properties']['firstname']).to eq 'Tester'
      end
    end

    it 'returns the correct lastname' do
      VCR.use_cassette("contact_client/find_by_id") do
        expect(response['properties']['lastname']).to eq 'Testi'
      end
    end
  end

  describe '#create' do
    subject(:response) { described_class.new.create(properties) }

    let(:properties) { { firstname: 'Darth', lastname: 'Vader', email: 'darth.vader@farbfox.de' } }

    it 'returns status code 201' do
      VCR.use_cassette("contact_client/create") do
        expect(response.code).to be 201
      end
    end

    it 'create the firstname' do
      VCR.use_cassette("contact_client/create") do
        expect(response['properties']['firstname']).to eq 'Darth'
      end
    end

    it 'updates the firstname' do
      VCR.use_cassette("contact_client/create") do
        expect(response['properties']['lastname']).to eq 'Vader'
      end
    end

    it 'updates the firstname' do
      VCR.use_cassette("contact_client/create") do
        expect(response['properties']['email']).to eq 'darth.vader@farbfox.de'
      end
    end
  end

  describe '#update' do
    subject(:response) { described_class.new.update(34351, properties) }

    let(:properties) { { firstname: 'Blubber' } }

    it 'returns status code 200' do
      VCR.use_cassette("contact_client/update") do
        expect(response.code).to be 200
      end
    end

    it 'updates the firstname' do
      VCR.use_cassette("contact_client/update") do
        expect(response['properties']['firstname']).to eq 'Blubber'
      end
    end
  end
end