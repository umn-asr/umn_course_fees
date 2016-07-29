class CourseResource < JSONAPI::Resource
  immutable

  attributes :class_name, :catalog_number, :term, :subject, :fees
end
