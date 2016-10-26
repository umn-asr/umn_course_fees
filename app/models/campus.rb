class Campus < ActiveRecord::Base
  self.table_name = DataSnapshots::Campuses.snapshot_name
  self.primary_key = "campus"

  has_many :terms, -> { order "strm" }
end
