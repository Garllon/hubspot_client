# frozen_string_literal: true

require 'spec_helper'

module HubspotClient
  describe Model::Property do
    let(:client_properties) { instance_double(Client::Properties) }
    let(:stub_properties_response) do
      { 'results' => [
        { 'name' => 'firstname', 'modificationMetadata' => { 'readOnlyValue' => false } },
        { 'name' => 'createdate', 'modificationMetadata' => { 'readOnlyValue' => true } }
      ] }
    end

    before do
      allow(Client::Properties)
        .to receive(:new)
        .and_return(client_properties)
      allow(client_properties)
        .to receive(:for)
        .and_return(stub_properties_response)
    end

    describe '.all_for' do
      it 'returns all properties' do
        result = described_class.all_for('contacts')

        expect(result['results'].first['name']).to equal('firstname')
      end
    end

    describe '.writable_property_names_for' do
      it 'returns the symbolized property keys' do
        result = described_class.writable_property_names_for('contacts')

        expect(result).to eq([:firstname])
      end
    end
  end
end
