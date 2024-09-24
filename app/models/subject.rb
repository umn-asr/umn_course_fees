class Subject < ActiveRecord::Base
  self.table_name = "subjects_daily"
  self.primary_key = "id"

  has_many :courses
end
