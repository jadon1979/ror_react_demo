class InventoryType < ApplicationRecord
  belongs_to :mso

  validates :name, presence: true, uniqueness: { scope: :mso_id }
end
