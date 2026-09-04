source 'https://rubygems.org'
ruby '3.3.0'

gem 'rails', '~> 7.1.3'
gem 'pg', '~> 1.5'
gem 'redis', '~> 5.0'
gem 'sidekiq', '~> 7.1'
gem 'puma', '~> 6.4'

gem 'hotwire-rails'
gem 'turbo-rails'
gem 'stimulus-rails'

gem 'devise', '~> 4.9'
gem 'pundit', '~> 2.3'
gem 'stripe', '~> 10.0'
gem 'aws-sdk-s3', '~> 1.146'
gem 'pg_search', '~> 2.3'
gem 'active_storage_validations', '~> 1.1'
gem 'image_processing', '~> 1.12'

gem 'responders', '~> 3.1'
gem 'rack-cors', '~> 2.0'

gem 'jbuilder', '~> 2.11'
gem 'sassc-rails', '~> 2.1'
gem 'importmap-rails', '~> 2.0'

group :development, :test do
  gem 'rspec-rails', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'rubocop-rails', '~> 2.24', require: false
  gem 'brakeman', '~> 6.0', require: false
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'shoulda-matchers', '~> 6.0'
  gem 'database_cleaner-active_record', '~> 2.1'
end
