source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1', '>= 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'rack'
gem "responders"
gem 'record_tag_helper', '~> 1.0'
gem 'rails-ujs'
gem 'serviceworker-rails'
gem 'webpacker'

#frontend
gem "twitter-bootstrap-rails"
gem 'font-awesome-sass'
gem 'will_paginate'

#form
gem 'simple_form'

#notification / activity
gem 'growlyflash'
gem 'public_activity'

#authentication
gem "devise"

#paymentsubscription
gem 'stripe'
gem 'money'

#search / sorting
gem 'pg_search'
gem 'jquery-ui-rails'

#upload
gem "trix"
gem 'aws-sdk-s3'
gem 'paperclip', '~> 4.2.0'
gem 'aws-sdk', '< 2.0'
gem 'dropzonejs-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem "rspec-rails"
  gem "email_spec"
  gem "letter_opener"
end

group :development do
  gem 'dotenv-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem "factory_bot_rails"
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
