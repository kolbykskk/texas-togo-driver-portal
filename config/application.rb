require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SellerDashboard
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.enabled = true
    config.assets.paths << Rails.root.join("app", "assets", "css")
    config.assets.paths << Rails.root.join("app", "assets", "css", "themes")
    config.assets.paths << Rails.root.join("app", "assets", "js", "pages")
    
    config.middleware.use Rack::Affiliates

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag.html_safe
    }
  end
end
