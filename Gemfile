source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/"

source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/" do
  ruby "3.2.2"

  gem "rails", "~> 7.0.8"
  gem "activerecord-oracle_enhanced-adapter", "~> 7.0.3"
  gem "lograge"
  gem "logstash-event"
  gem "puma"
  gem "ruby-oci8", "~> 2.2", ">= 2.2.9"
  gem "view_builder", "~> 0.3.0"
  gem "snapshot_builder", "~> 0.12.0"
  gem "grant_manager", "~> 0.10.0"
  gem "peoplesoft_models", "~> 0.4.0"
  gem "json", "~> 2.7.1"
  gem "jsonapi-resources", "~> 0.9.12"
  gem "umn_peoplesoft_models", "~> 0.15.0"
  gem "nokogiri", "~> 1.16.0"
  gem "rack-cache", require: "rack/cache"
  gem "rack-cors"

  group :development, :test do
    gem "rspec", "~> 3.12.0"
    gem "rspec-rails", "~> 6.1.1"
    gem "standard"
  end

  group :development do
    gem "brakeman", "~> 6", require: false
    gem "bundler-audit"
  end
end
