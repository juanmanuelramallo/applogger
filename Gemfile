source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7.2'

gem 'dotenv-rails'
gem 'maxminddb'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'sass-rails', '>= 6'
gem 'sidekiq', '~> 6.2.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'rspec-rails', '~> 5.0.1'
  gem 'standard', '~> 1.1.1'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "tailwindcss-rails", "~> 0.3.3"
