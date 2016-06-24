class Term < ActiveRecord::Base
  self.table_name = DataViews::Terms.view_name
  self.primary_key = "id"

  belongs_to :campus
  has_many :subjects

  def active
    current_term == 'true'
  end
end
