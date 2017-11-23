source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'rack'

#frontend
gem "twitter-bootstrap-rails"
gem 'font-awesome-sass'

#form
gem "simple_form"
gem "cocoon"

#charts
gem "chartkick"
gem 'groupdate', '~> 2.1.1'
gem 'active_median', '~> 0.1.0'

#notification / activity
gem 'growlyflash'
gem 'public_activity'

#authentication
gem "devise"

#paymentsubscription
gem 'stripe'
gem 'money'

#search
gem 'pg_search'

#upload images
gem 'paperclip'
gem 'aws-sdk', '< 3.0'
gem 'dropzonejs-rails'
gem 'dotenv-rails', groups: [:development]

group :development, :test do
  gem 'byebug', platform: :mri
  gem "rspec-rails"
  gem "email_spec"
  gem "letter_opener"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem "factory_girl_rails"
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
