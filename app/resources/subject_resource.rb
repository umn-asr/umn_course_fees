class SubjectResource < JSONAPI::Resource
  immutable

  attributes :abbreviation, :name

  has_one :term, :campus
  has_many :courses
end
