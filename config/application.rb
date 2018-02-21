require File.expand_path('../boot',__FILE__)
#require_relative 'boot'


require 'csv'

require 'rails/all'

require 'iconv'
#
if defined?(Bundler)
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
#
end

module Audi
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
