class CourseResource < JSONAPI::Resource
  immutable

  attributes :class_name, :catalog_number, :section, :fee_description, :fee_type, :amount

  has_one :subject
end
