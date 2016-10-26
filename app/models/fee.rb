class Fee < ActiveRecord::Base
  self.table_name = DataSnapshots::Fees.snapshot_name
  self.primary_key = "id"

  belongs_to :course
end
