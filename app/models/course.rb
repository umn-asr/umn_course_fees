class Course < ActiveRecord::Base
  self.table_name = DataViews::CourseFees.view_name
  self.primary_key = "id"

  belongs_to :subject
end
