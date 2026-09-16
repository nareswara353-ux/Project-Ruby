Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" } }
  config.options[:concurrency] = Integer(ENV.fetch("SIDEKIQ_CONCURRENCY") { 5 })
  config.options[:queues] = %w[critical default low]
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" } }
end
