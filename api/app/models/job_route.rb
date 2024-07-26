class JobRoute < ApplicationRecord
  belongs_to :user
  belongs_to :area
  belongs_to :company

  has_many :job_route_notes
  has_many :inventories

  enum :status, [
    :assigned,
    :canceled,
    :completed,
    :held,
    :in_service,
    :pending,
    :reschedule_pending,
    :rescheduled
  ], default: :pending
end
