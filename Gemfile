source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/" do
  ruby File.read('.ruby-version', mode: 'rb').chomp

  gem "rails", "5.0.0.1"
  gem "activerecord-oracle_enhanced-adapter", "~> 1.7.11"
  gem "lograge"
  gem "logstash-event"
  gem "ruby-oci8", "~> 2.2", ">= 2.2.9"
  gem "view_builder", '~> 0.2.0'
  gem "snapshot_builder", '~> 0.7.0'
  gem "peoplesoft_models", '~> 0.3.1'
  gem "json", "~> 1.8.6"
  gem "jsonapi-resources"
  gem "umn_peoplesoft_models", '~> 0.5.0'

  group :development, :test do
    gem "rspec", "~> 3.10.0"
    gem "rspec-rails", "~> 4.1.2"
  end

  group :development do
    gem "lastpassify"
    gem "rubocop"
    gem "overcommit"
    gem "brakeman", "~> 3", require: false
    gem "capistrano", "~> 3.4.0"
    gem "capistrano-logrotate", "0.4.0"
    gem "capistrano-rails", "~> 1.1.3"
    gem "capistrano-passenger", "~> 0.1.1"
  end
end
