# frozen_string_literal: true

require 'spec_helper'

module HubspotClient
  describe Model::CommunicationPreference do
    let(:client_communication_preference) { instance_double(Client::CommunicationPreference) }

    before do
      allow(Client::CommunicationPreference).to receive(:new).and_return(client_communication_preference)
    end

    describe '.all' do
      before do
        allow(client_communication_preference).to receive(:definitions)
      end

      it 'receives all definitions' do
        described_class.all

        expect(client_communication_preference).to have_received(:definitions)
      end
    end
  end
end
