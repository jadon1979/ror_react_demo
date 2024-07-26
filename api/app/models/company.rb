class Company < ApplicationRecord
  belongs_to :mso
  belongs_to :state

  has_many :job_routes
  has_many :technicians
  has_many :users, through: :technicians

  validates :name, presence: true, uniqueness: { scope: :mso_id }
end
