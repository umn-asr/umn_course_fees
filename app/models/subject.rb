class Subject < ActiveRecord::Base
  self.table_name = DataSnapshots::Subjects.snapshot_name
  self.primary_key = "id"

  has_many :courses
end
