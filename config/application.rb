require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ideagora
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Use AEST by default
    config.time_zone = 'Sydney'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec
      g.stylesheets false
    end
    
    # Enable the asset pipeline.
    config.assets.enabled = true  

    # Version of your assets, change this if you want to expire all your assets.
    config.assets.version = '1.0'

    # Precompile directly referenced assets.
    config.assets.precompile << "jquery.dataTables-1.7.6.min.js"
  end
end
