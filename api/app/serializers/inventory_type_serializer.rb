class InventoryTypeSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :mso_id, :price, :created_at, :updated_at
end
