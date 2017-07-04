require 'spec_helper'

require_relative '../config/application'

ActiveRecord::Base.establish_connection YAML.load_file('config/database.yml')[Rails.env]

Dir[Rails.root.join('app/*/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model
  end
end
