class Fee < ActiveRecord::Base
  self.primary_key = "id"

  belongs_to :course
end
