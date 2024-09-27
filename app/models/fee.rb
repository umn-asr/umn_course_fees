class Fee < ActiveRecord::Base
  self.table_name = "fees"
  self.primary_key = "id"

  belongs_to :course
end
