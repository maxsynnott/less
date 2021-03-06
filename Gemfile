source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Self-Added Gems:
gem 'devise'
gem 'stripe'
gem 'simple_form'
gem 'font_awesome5_rails'
gem 'country_select'
gem 'phonelib'
gem 'stripe_event'
gem 'activeadmin'
gem 'acts_as_votable'
gem 'js-routes'
gem 'cocoon'
gem 'will_paginate'
gem 'will_paginate-bootstrap4'
gem 'pg_search'
gem 'acts-as-taggable-on'
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'rails-i18n'
gem 'geocoder'
gem 'flag-icons-rails'
gem 'cloudinary'
gem 'faker'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'ngrok-tunnel'
gem 'i18n-js'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Self-Added Gems:
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'traceroute'
  gem 'pry'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Self-Added Gems:
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'simplecov', require: false
  gem 'launchy'

  # Self-Added Gems:
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
