require 'spec_helper'

require_relative '../config/application'

Dir[Rails.root.join('app/services/*.rb')].each { |f| require f }
