require 'rails_helper'

RSpec.describe Site, type: :model do
  it { should have_many :pages }

  it { should validate_presence_of :url }

  it { should validate_uniqueness_of(:url).case_insensitive }
end
