source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'rack'
gem "responders"
gem 'record_tag_helper', '~> 1.0'

#frontend
gem "twitter-bootstrap-rails"
gem 'font-awesome-sass'

#form
gem "cocoon"
gem 'simple_form'

#notification / activity
gem 'growlyflash'
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
gem 'sweet-alert2-rails'
gem 'public_activity'

#authentication
gem "devise"
gem "omniauth-google-oauth2"

#paymentsubscription
gem 'stripe'
gem 'money'

#search / sorting
gem 'pg_search'
gem 'jquery-ui-rails'
gem 'select2-rails'
gem 'underscore-rails'

#upload images
gem 'link_thumbnailer'
gem 'paperclip'
gem 'aws-sdk', '< 3.0'
gem 'delayed_paperclip'

#prograssive web app
gem 'serviceworker-rails'

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
  gem "factory_girl_rails"
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
