class MsoSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :domain, :created_at, :updated_at
end
