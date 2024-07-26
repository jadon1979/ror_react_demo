class State < ApplicationRecord
  has_many :areas

  validates :name, presence: true, uniqueness: true
  validates :abbreviation, presence: true, uniqueness: true
end
