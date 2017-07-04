class Site < ActiveRecord::Base
  has_many :pages

  validates :url, presence: true, uniqueness: { case_sensitive: false }
end
