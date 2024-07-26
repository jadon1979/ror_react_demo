class Area < ApplicationRecord
  belongs_to :mso
  belongs_to :state

  has_many :inventories
end
