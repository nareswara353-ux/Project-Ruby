require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module ProjectRuby
  class Application < Rails::Application
    config.load_defaults 7.2
    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.autoload_lib(ignore: %w[assets tasks])

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.request_specs true
      g.controller_specs true
      g.system_tests = nil
    end

    config.active_job.queue_adapter = :sidekiq
    config.active_record.schema_format = :sql

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    config.action_mailer.default_url_options = { host: ENV.fetch("APP_HOST", "localhost:3000") }
  end
end
