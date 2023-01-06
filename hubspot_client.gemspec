# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hubspot_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'hubspot_client'
  spec.version       = HubspotClient::VERSION
  spec.authors       = %w[Garllon romankonz]
  spec.email         = %w[garllon@protonmail.com roman@konz.me]

  spec.summary       = 'Hubspot client'
  spec.description   = 'Hubspot client to handle CRM objects.'
  spec.homepage      = 'https://github.com/Farbfox/hubspot_client/blob/main/README.md'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Farbfox/hubspot_client'
  spec.metadata['changelog_uri'] = 'https://github.com/Farbfox/hubspot_client/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.20.0'

  spec.add_development_dependency 'bundler', '~> 2.3.26'
  spec.add_development_dependency 'dotenv', '~> 2.8', '>= 2.8.1'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.39'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.15'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
  spec.add_development_dependency 'vcr', '~> 6.1'
  spec.add_development_dependency 'webmock', '~> 3.18'
end
