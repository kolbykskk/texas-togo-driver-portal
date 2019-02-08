require 'sidekiq'

Sidekiq.configure_client do |config|
   config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
   config.redis = { :size => 4 }
   config.server_middleware do |chain|
      chain.add Sidekiq::Middleware::Server::RetryJobs, :max_retries => 0
   end
end