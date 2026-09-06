require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Lms
  class Application < Rails::Application
    config.load_defaults 7.1
    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.autoload_lib(ignore: %w(assets tasks))

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.request_specs true
      g.controller_specs true
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
