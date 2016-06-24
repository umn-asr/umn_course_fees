class SubjectResource < JSONAPI::Resource
  immutable

  attributes :abbreviation, :name

  has_one :term, :campus
end
