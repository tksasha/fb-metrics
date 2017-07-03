require_relative 'boot'

Bundler.require(*Rails.groups)

module FBParser
  class Application < Rails::Application
  end
end
