class Inventory < ApplicationRecord
  belongs_to :inventory_type
  belongs_to :job_route
  belongs_to :area
  belongs_to :user
  belongs_to :mso
end
