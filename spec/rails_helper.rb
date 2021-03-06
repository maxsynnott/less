# Simplecov config (Must be at the top of this file)
require 'simplecov'

SimpleCov.start do
  add_filter "spec/"
  add_filter "config/"
  add_filter "app/services/stripe/handlers/event.rb" # Can't trigger error handlers
  add_filter "app/controllers/api/v1/base_controller.rb" # Handles server errors

  add_group "Lib", "lib/"
  add_group "Admin", "app/admin"
  add_group "Models", "app/models"
  add_group "Mailers", "app/mailers"
  add_group "Helpers", "app/helpers"
  add_group "Channels", "app/channels"
  add_group "Services", "app/services"
  add_group "Controllers", "app/controllers"
end
#

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'database_cleaner'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers

  # default: :selenium_chrome_headless
  # :selenium_chrome for visualisation
  Capybara.javascript_driver = :selenium_chrome_headless
  
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # DatabaseCleaner Config
  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
  # 

  # FactoryBot Config
  config.include FactoryBot::Syntax::Methods # Gives access to methods like build/create
  # 

  # Devise Config
  config.include Devise::Test::ControllerHelpers, type: :controller # Gives access to methods like sign_in
  # 

  # ShouldaMatchers Config
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
  #

  # Ngrok / test webhook config
  config.before(:suite) do
    Stripe::WebhookEndpoint.list.data.each { |webhook| Stripe::WebhookEndpoint.update(webhook.id, disabled: true) }

    Capybara.server_port = 3001 # 3001 is Ngrok's default port however this could be changed
    Ngrok::Tunnel.start

    puts "Ngrok started at #{Ngrok::Tunnel.ngrok_url_https}"
  end

  config.before(:each, ngrok: true) do
    webhook = Stripe::WebhookEndpoint.create(
      url: "#{Ngrok::Tunnel.ngrok_url_https}/stripe/webhook",
      enabled_events: [
        'payment_intent.succeeded'
      ]
    )

    StripeEvent.signing_secret = webhook.secret
  end

  config.after(:each, ngrok: true) do
    webhook = Stripe::WebhookEndpoint.list.data.first

    Stripe::WebhookEndpoint.delete(webhook.id)
  end

  config.after(:suite) do
    Ngrok::Tunnel.stop

    Stripe::WebhookEndpoint.list.data.each { |webhook| Stripe::WebhookEndpoint.update(webhook.id, disabled: false) }
  end
  #

  config.before(:each, js: true) do
    Capybara.page.driver.browser.manage.window.resize_to(1920, 1080)
  end


  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
