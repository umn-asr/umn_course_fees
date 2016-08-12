source "https://rubygems.org"
ruby "2.3.1"

gem "rails", "4.2.7.1"
gem "activerecord-oracle_enhanced-adapter", "~> 1.6", ">= 1.6.7"
gem "ruby-oci8", "~> 2.2", ">= 2.2.2"
gem "view_builder", git: "git@github.umn.edu:asrweb/view_builder.git", ref: "e4fcfbeceeedef11cc0645f573e6d1909147550a"
gem "peoplesoft_models", git: "git@github.umn.edu:asrweb/peoplesoft_models.git", ref: "3b0c747674c436131591b8fdadbeb5a01604c05c"
gem "jsonapi-resources"
gem "umn_peoplesoft_models", git: "git@github.umn.edu:asrweb/umn_peoplesoft_models.git", ref: "7f646e8e049a9bb5867ae2e93e46032d689e3603"

group :development, :test do
  gem "rspec", "~> 3.4"
  gem "rspec-rails", "~> 3.4"
end

group :development do
  gem "rubocop"
  gem "overcommit"
  gem "brakeman", "~> 3", require: false
  gem "capistrano", "~> 3.4.0"
  gem "capistrano-rails", "~> 1.1.3"
  gem "capistrano-passenger", "~> 0.1.1"
end
