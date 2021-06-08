class CourseResource < JSONAPI::Resource
  immutable

  attributes :class_name, :catalog_number, :term, :subject, :fees

  def term
    @model.term.attributes
  end

  def subject
    @model.subject.attributes
  end

  def fees
    @model.fees.map(&:attributes)
  end
end
