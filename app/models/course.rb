class Course < ActiveRecord::Base
  self.table_name = "courses_daily"
  self.primary_key = "id"

  belongs_to :term
  belongs_to :subject
  has_many :fees
end
