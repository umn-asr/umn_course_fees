class Subject < ActiveRecord::Base
  self.primary_key = "id"

  has_many :courses
end
