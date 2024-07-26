class AreaSerializer
  include JSONAPI::Serializer

  attributes :id,
    :mso_id,
    :name,
    :address_1,
    :address_2,
    :city,
    :state_id,
    :zip,
    :created_at,
    :updated_at

  belongs_to :mso
end
