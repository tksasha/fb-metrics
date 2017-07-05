require_relative 'boot'

Bundler.require(*Rails.groups)

module FBParser
  class Application < Rails::Application
    config.load_defaults 5.1
  end
end

Rails.logger = ActiveSupport::Logger.new Rails.root.join 'log', "#{ Rails.env }.log"
