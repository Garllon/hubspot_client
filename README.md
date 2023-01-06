
# HubspotClient

[![Gem
Version](https://badge.fury.io/rb/hubspot_client.svg)](https://badge.fury.io/rb/hubspot_client)
[![Rspec and Rubocop](https://github.com/Farbfox/hubspot_client/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Farbfox/hubspot_client/actions/workflows/ci.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/ceed6d4994b8705c8558/maintainability)](https://codeclimate.com/github/Farbfox/hubspot_client/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ceed6d4994b8705c8558/test_coverage)](https://codeclimate.com/github/Farbfox/hubspot_client/test_coverage)

A Hubspot Client. Currently we only support the following CRM Parts:
* Contact
* Company
* Properties

Also:
* Communication Preferences

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hubspot_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubspot_client

## Usage

You need to configure the `hubspot_client` first:
``` ruby
HubspotClient.configure do |config|
  config.access_token = 'PRIVATE_APP_ACCESS_TOKEN'
end
```

## Models

The following models exists and should be mainly used. However you can also use the clients itself,
if you like, but you need to understand the code by yourself.

### Contact

[Hubspot- API](https://developers.hubspot.com/docs/api/crm/contacts)

#### find
You can find by `hubspot_id` or `email`

```ruby
HubspotClient::Model::Contact.find(hubspot_id: '1337')
=> #<HubspotClient::Model::Contact createdate="2022-11-11T11:57:15.901Z", email="vader@example.com", firstname="Darth", hs_object_id="1337", lastmodifieddate="2022-11-17T13:31:00.526Z", lastname="Vader">

HubspotClient::Model::Contact.find(email: 'vader@example.com')
=> #<HubspotClient::Model::Contact createdate="2022-11-11T11:57:15.901Z", email="vader@example.com", firstname="Darth", hs_object_id="1337", lastmodifieddate="2022-11-17T13:31:00.526Z", lastname="Vader">
```

#### associate_primary_company

```ruby
hubspot_contact = HubspotClient::Model::Contact.find(hubspot_id: '1337')
=> #<HubspotClient::Model::Contact createdate="2022-11-11T11:57:15.901Z", email="vader@example.com", firstname="Darth", hs_object_id="1337", lastmodifieddate="2022-11-17T13:31:00.526Z", lastname="Vader"> 

hubspot_contact.associate_primary_company(6582942445)
=> true
```

### Company

Here you can find the [Hubspot-Companies-API-Documentation](https://developers.hubspot.com/docs/api/crm/companies)

#### find

Find a company be `hubspot_id`

```ruby
HubspotClient::Model::Company.find(hubspot_id: '6614067165')
=> #<HubspotClient::Model::Company address="Todesternstraße 1", city="Todestern", createdate="2022-11-28T13:45:40.989Z", hs_lastmodifieddate="2022-11-28T13:45:44.933Z", hs_object_id="6614067165", name="Todesternverwaltungs GmbH", phone="0152123456789", zip="1337">
```

#### create

```ruby
example_properties = { name: 'Todesternverwaltungs GmbH',
                       phone: '0152123456789',
                       address: 'Todesternstraße 1',
                       city: 'Todestern',
                       zip: '1337' }

HubspotClient::Model::Company.create(example_properties)
=> #<HubspotClient::Model::Company address="Todesternstraße 1", city="Todestern", createdate="2022-11-28T13:45:40.989Z", hs_lastmodifieddate="2022-11-28T13:45:40.989Z", hs_object_id="6614067165", hs_pipeline="companies-lifecycle-pipeline", lifecyclestage="lead", name="Todesternverwaltungs GmbH", phone="0152123456789", zip="1337">  
```

#### update

```ruby
hubspot_company = HubspotClient::Model::Company.find(hubspot_id: '6614067165')

# You can change the attribute like so:
hubspot_company.name = 'Blubber'

# or like so:
hubspot_company.assign_attributes(name: 'Blubber')

# then you can run:
hubspot_company.update

# you can also do it directly in the update method:
hubspot_company.update({ name: 'Blubber' })
```

### Communication-Preference

[Hubspot- API](https://developers.hubspot.com/docs/api/marketing-api/subscriptions-preferences)

## Development

After checking out the repo, run
```shell
bundle install
```

Then, run
```shell
bundle exec rspec spec
```
to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

You need a `.env` file looks like, if you want to test it against your hubspot instance:
```shell
ACCESS_TOKEN=<youur_private_app_access_token>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/farbfox/hubspot_client](https://github.com/farbfox/hubspot_client). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HubspotClient project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/farbfox/hubspot_client/blob/master/CODE_OF_CONDUCT.md).
