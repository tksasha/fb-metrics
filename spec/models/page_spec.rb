require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should validate_presence_of :url }

  it { should validate_uniqueness_of(:url).case_insensitive }

  it { should have_one :metric }
end
