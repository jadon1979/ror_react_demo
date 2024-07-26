class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
    :first_name,
    :last_name,
    :full_name,
    :email,
    :status,
    :role,
    :phone_number,
    :address_1,
    :address_2,
    :city,
    :zip,
    :state,
    :created_at,
    :updated_at
end
