class SubjectResource < JSONAPI::Resource
  immutable

  attributes :abbreviation, :name

  has_many :courses
end
