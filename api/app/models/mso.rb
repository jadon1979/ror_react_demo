class Mso < ApplicationRecord
  has_many :companies
  has_many :areas
  has_many :inventories
  has_many :inventory_types

  validates :name, presence: true
  validates :domain, presence: true, uniqueness: true
end
