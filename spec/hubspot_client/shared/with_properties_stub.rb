# frozen_string_literal: true

RSpec.shared_context 'with properties stub', shared_context: :metadata do
  let(:stub_client_properties) { instance_double(HubspotClient::Client::Properties) }
  let(:stub_client_properties_response) do
    { 'results' => [
      { 'name' => 'firstname', 'modificationMetadata' => { 'readOnlyValue' => false } },
      { 'name' => 'createdate', 'modificationMetadata' => { 'readOnlyValue' => true } }
    ] }
  end

  before do
    allow(HubspotClient::Client::Properties)
      .to receive(:new)
      .and_return(stub_client_properties)
    allow(stub_client_properties)
      .to receive(:for)
      .and_return(stub_client_properties_response)
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'with properties stub', include_shared: true
end
