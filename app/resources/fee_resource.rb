class FeeResource < JSONAPI::Resource
  immutable

  attributes :amount, :fee_type, :fee_description, :section

  has_one :course
end
