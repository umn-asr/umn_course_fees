class Course < ActiveRecord::Base
  self.primary_key = "id"

  belongs_to :term
  belongs_to :subject
  has_many :fees
end
