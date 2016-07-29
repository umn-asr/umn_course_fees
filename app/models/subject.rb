class Subject < ActiveRecord::Base
  self.table_name = DataViews::Subjects.view_name
  self.primary_key = "id"

  has_many :courses
end
