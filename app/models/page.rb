class Page < ActiveRecord::Base
  validates :url, presence: true, uniqueness: { case_sensitive: false }

  has_one :metric
end
