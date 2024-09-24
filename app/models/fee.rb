class Fee < ActiveRecord::Base
  self.table_name = "fees_daily"
  self.primary_key = "id"

  belongs_to :course
end
