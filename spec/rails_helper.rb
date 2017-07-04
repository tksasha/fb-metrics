require 'spec_helper'

require_relative '../config/application'

Dir[Rails.root.join('app/*/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
