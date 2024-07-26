class JobRouteNote < ApplicationRecord
  belongs_to :job_route
  belongs_to :user

  validates :user_id, presence: true
  validates :job_route_id, presence: true
  validates :note, presence: true
end
