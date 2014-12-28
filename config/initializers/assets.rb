# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Precompile additional stylesheets.
Rails.application.config.assets.precompile += %w( skel-noscript.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( style-desktop.css )

# Precompile additional javascripts.
Rails.application.config.assets.precompile += %w( skel.min.js )
Rails.application.config.assets.precompile += %w( skel-panels.min.js )
Rails.application.config.assets.precompile += %w( init.js )