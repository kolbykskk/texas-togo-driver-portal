# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( codebase.min.css )
Rails.application.config.assets.precompile += %w( codebase.app.min.js )
Rails.application.config.assets.precompile += %w( codebase.core.min.js )
Rails.application.config.assets.precompile += %w( op_auth_signin.min.js )
Rails.application.config.assets.precompile += %w( op_auth_signup.min.js )
Rails.application.config.assets.precompile += %w( Chart.bundle.min.js )
Rails.application.config.assets.precompile += %w( be_pages_dashboard.min.js )
Rails.application.config.assets.precompile += %w( jquery.validate.min.js )
Rails.application.config.assets.precompile += %w( op_auth_reminder.min.js )

Rails.application.config.assets.precompile += %w( vendor/assets/images/* )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
