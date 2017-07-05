require_relative 'config/application'

Dir[Rails.root.join('app/*/*.rb')].each { |f| require f }
