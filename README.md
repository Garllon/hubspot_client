
# HubspotClient

An simple Hubspot Client. We only like to support the CRm features for the moment. Maybe we do more.

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

The idea is that the models behave like an ActiveRecord Model.

### Contact - HubspotClient::Model::Contact

[Hubspot- API](https://developers.hubspot.com/docs/api/crm/contacts)

#### find
You can find by `hubspot_id` or `email`
```ruby
HubspotClient::Model::Contact.find(hubspot_id: '1337')
=> #<HubspotClient::Model::Contact createdate="2022-11-11T11:57:15.901Z", email="vader@example.com", firstname="Darth", hs_object_id="1337", lastmodifieddate="2022-11-17T13:31:00.526Z", lastname="Vader">

HubspotClient::Model::Contact.find(email: 'vader@example.com')
=> #<HubspotClient::Model::Contact createdate="2022-11-11T11:57:15.901Z", email="vader@example.com", firstname="Darth", hs_object_id="1337", lastmodifieddate="2022-11-17T13:31:00.526Z", lastname="Vader">
```

### Company

[Hubspot- API](https://developers.hubspot.com/docs/api/crm/companies)

### Subscription-Preferences

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
