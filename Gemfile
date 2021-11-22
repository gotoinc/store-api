source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.1'

# Run any kind of code in parallel processes (https://github.com/grosser/parallel)
gem 'parallel', '~> 1.19'

group :development, :test do
  gem 'bcrypt', '~> 3.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 5.0'

  # RSpec JUnit XML formatter (http://github.com/sj26/rspec_junit_formatter)
  gem 'rspec_junit_formatter', '~> 0.4'

  # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails', '~> 6.1'

  # prettier plugin for the Ruby programming language
  gem 'prettier', '~> 1.0'

  # An IRB alternative and runtime developer console
  gem 'pry', '~> 0.13'

  # Use Pry as your rails console
  gem 'pry-rails', '~> 0.3'

  # Fast debugging with Pry
  gem 'pry-byebug', '~> 3.7' # Call 'byebug' anywhere in the code to stop execution and get a debugger console

  # Provides YARD and extended documentation support for Pry
  gem 'pry-doc', '~> 1.0'

  # Automatic Ruby code style checking tool
  gem 'rubocop', '~> 1.6', require: false

  # Automatic Rails code style checking tool
  gem 'rubocop-rails', '~> 2.9'

  # A RuboCop extension for Faker
  gem 'rubocop-faker', '~> 1.1'

  # Rubocop extension for performance
  gem 'rubocop-performance', '~> 1.9', require: false

  # Add a comment summarizing to Models
  gem 'annotate', '~> 3.1', require: false

  # Swagger tooling for Rails API's
  gem 'rswag-specs'

  # Guard keeps an eye on your file modifications (http://guardgem.org)
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false

  # Patch-level verification for bundler.
  gem 'bundler-audit', '~> 0.8.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Catch and open letter locally
  gem 'letter_opener', '~> 1.7'
  # A single dependency-free binary to manage all your git hooks (https://github.com/Arkweid/lefthook)
  gem 'lefthook'
  # Really simple YAML lint (https://github.com/Pryz/yaml-lint)
  gem 'yaml-lint'
end

group :test do
  # Strategies for cleaning databases. Can be used to ensure a clean state for testing
  gem 'database_cleaner', '~> 1.8'

  # Code coverage with automatic merging of coverage across test suites
  gem 'simplecov', '~> 0.20'

  # Show failing specs instantly
  gem 'rspec-instafail'

  # Shoulda Matchers provides RSpec one-liners to test common Rails functionality that, if written by hand, would be
  # much longer, more complex, and error-prone.
  gem 'shoulda-matchers', '~> 4.0'
end

# A fast JSON:API serializer for Ruby Objects.
gem 'jsonapi-serializer', '~> 2.1'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Shim to load environment variables from .env into ENV in development.
gem 'dotenv-rails', '~> 2.7', groups: [:development, :test]

# Swagger tooling for Rails API's
gem 'rswag-api'
gem 'rswag-ui'

# Authentication
# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard
gem 'jwt', '~> 2.2'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise', '~> 4.8'
# devise-jwt is a devise extension which uses JWT tokens for user authentication.
gem 'devise-jwt', '~> 0.8.1'

# Easily generate fake data
gem 'ffaker', '~> 2.19'

# The AWS SDK for Ruby is available from RubyGems.
gem 'aws-sdk-s3', '~> 1.0', require: false

# CanCan is an authorization library for Ruby on Rails
gem 'cancancan', '~> 3.3.0'

# This is the notifier gem for integrating apps with the Honeybadger Exception Notifier for Ruby and Rails.
gem 'honeybadger', '~> 4.9.0'

# Library for adding finite state machines to Ruby classes.
gem 'aasm', '~> 5.2.0'

# A micro library providing Ruby objects with Publish-Subscribe capabilities
gem 'wisper', '2.0.0'

# Centralization of locale data collection for Ruby on Rails.
gem 'rails-i18n', '~> 6.0.0'

# File Validators gem adds file size and content type validations to ActiveModel
gem 'file_validators', '~> 3.0.0'

# Provides higher-level image processing helpers that are commonly needed when handling image uploads.
gem 'image_processing', '~> 1.2'

# Pagination library that integrates with Ruby on Rails
gem 'will_paginate', '~> 3.1.0'

# A ruby wrapper for ImageMagick or GraphicsMagick command line.
gem 'mini_magick', '~> 4.1'
