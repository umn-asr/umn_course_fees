source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/" do
  ruby File.read(".ruby-version", mode: "rb").chomp

  gem "rails", "~> 7.0"
  gem "activerecord-oracle_enhanced-adapter", "~> 7.0.2"
  gem "listen"
  gem "lograge"
  gem "logstash-event"
  gem "ruby-oci8", "~> 2.2", ">= 2.2.9"
  gem "view_builder", "~> 0.2.0"
  gem "snapshot_builder", "~> 0.10.0"
  gem "grant_manager", "~> 0.7.0"
  gem "peoplesoft_models", "~> 0.4.0"
  gem "json", "~> 2.5.1"
  gem "jsonapi-resources", "~>0.9.0"
  gem "umn_peoplesoft_models", "~> 0.13.0"
  gem "nokogiri", "~> 1.14.0"
  gem "rack-cache", require: "rack/cache"
  gem "rack-cors"

  group :development, :test do
    gem "bcrypt_pbkdf", ">= 1.0", "< 2.0"
    gem "ed25519", ">= 1.2", "< 2.0"
    gem "rspec", "~> 3.10.0"
    gem "rspec-rails", "~> 4.1.2"
    gem "standard"
  end

  group :development do
    gem "lastpassify"
    gem "brakeman", "~> 5", require: false
    gem "bundler-audit"
    gem "capistrano", "~> 3.16.0"
    gem "capistrano-logrotate", "0.4.0"
    gem "capistrano-passenger", "~> 0.1.1"
    gem "capistrano-rails", "~> 1.6.1"
  end
end
