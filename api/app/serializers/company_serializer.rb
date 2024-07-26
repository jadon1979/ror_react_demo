class CompanySerializer
  include JSONAPI::Serializer

  attributes :id,
    :name,
    :phone_number,
    :address_1,
    :address_2,
    :city,
    :zip,
    :state,
    :created_at,
    :updated_at

  belongs_to :mso
end
