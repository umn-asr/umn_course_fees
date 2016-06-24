class TermResource < JSONAPI::Resource
  immutable

  attributes :campus_id, :strm, :name, :active

  has_one :campus
  has_many :subjects
end
