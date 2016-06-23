class CampusResource < JSONAPI::Resource
  immutable

  attributes :name

  has_many :terms
end
