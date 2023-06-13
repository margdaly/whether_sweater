class ActivitiesSerializer
  include  JSONAPI::Serializer
  set_id { nil }
  attributes :destination, :forecast, :activities
end
