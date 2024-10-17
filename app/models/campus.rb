class Campus < ActiveRecord::Base
  self.primary_key = "campus"

  has_many :terms, -> { order "strm" }
end
