class Campus < ActiveRecord::Base
  self.table_name = DataViews::Campuses.view_name
  self.primary_key = "campus"

  has_many :terms, -> { order "strm" }
end
