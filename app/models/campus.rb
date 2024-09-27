class Campus < ActiveRecord::Base
  self.table_name = "campuses"
  self.primary_key = "campus"

  has_many :terms, -> { order "strm" }
end
