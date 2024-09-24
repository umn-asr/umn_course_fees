class Campus < ActiveRecord::Base
  self.table_name = "campuses_daily"
  self.primary_key = "campus"

  has_many :terms, -> { order "strm" }
end
