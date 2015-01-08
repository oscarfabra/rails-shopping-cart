# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Additional stylesheets to be precompiled.
Rails.application.config.assets.precompile += %w( font-awesome.min.css )
Rails.application.config.assets.precompile += %w( style-1000px.css )
Rails.application.config.assets.precompile += %w( style-desktop.css )
Rails.application.config.assets.precompile += %w( style-mobile.css )
Rails.application.config.assets.precompile += %w( skel.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( ie/v8.css )
Rails.application.config.assets.precompile += %w( ie/v9.css )
Rails.application.config.assets.precompile += %w( ie/PIE.htc )

# Additional javascripts to be precompiled.
Rails.application.config.assets.precompile += %w( ie/html5shiv.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( jquery.scrolly.min.js )
Rails.application.config.assets.precompile += %w( skel.min.js )
Rails.application.config.assets.precompile += %w( init.js )