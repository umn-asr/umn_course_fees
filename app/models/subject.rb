class Subject < ActiveRecord::Base
  self.table_name = "subjects"
  self.primary_key = "id"

  has_many :courses
end
