class JobRouteNoteSerializer
  include JSONAPI::Serializer

  attributes :id

  belongs_to :user
end
