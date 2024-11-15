source "https://rubygems.org"
ruby "3.3.5"


gem "rails", github: "rails/rails", branch: "main"
gem "propshaft"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false

gem "kamal", require: false

gem "thruster", require: false
gem "aws-sdk-s3", require: false
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false

  gem "factory_bot_rails"
  gem "rspec-rails", "~> 7.0.0"
  gem "ruby-lsp", require: false

  gem "faker"
  gem "htmlbeautifier"
end

group :development do
  gem "web-console"
end

group :test do
  gem "shoulda-matchers", "~> 6.0"
  gem "simplecov", require: false
end

gem "devise", "~> 4.9"
