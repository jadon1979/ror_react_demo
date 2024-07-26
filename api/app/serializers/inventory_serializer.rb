class InventorySerializer
  include JSONAPI::Serializer

  attributes :id,
    :action_status_id,
    :inventory_type_id,
    :serial_number,
    :date_received,
    :date_refreshed,
    :date_issued,
    :date_signed,
    :date_installed,
    :date_returned,
    :area_id,
    :tech_id,
    :hhc_completed,
    :account_number,
    :job_route_id,
    :user_id,
    :created_at,
    :updated_at

  belongs_to :inventory_type
  belongs_to :job_route
  belongs_to :user
  belongs_to :area
end