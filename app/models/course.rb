class Course < ActiveRecord::Base
  self.table_name = DataSnapshots::Courses.snapshot_name
  self.primary_key = "id"

  belongs_to :term
  belongs_to :subject
  has_many :fees
end
