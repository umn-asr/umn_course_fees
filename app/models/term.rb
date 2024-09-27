class Term < ActiveRecord::Base
  self.table_name = "terms"
  self.primary_key = "id"

  belongs_to :campus
  has_many :courses, -> { includes(:subject).includes(:fees).includes(:term) }

  def active
    current_term == "true"
  end
end
