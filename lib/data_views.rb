module DataViews
  def self.root
    @root ||= File.expand_path(File.join("..", ".."), __FILE__)
  end

  def self.environment
    @environment ||= Rails.env || "development"
  end

  def self.environment=(other)
    @environment = other
  end
end

require_relative "../config/initializers/peoplesoft_models"
require_relative "../config/initializers/data_views"
require "view_builder"
Dir.glob(File.join(File.dirname(__FILE__), "data_views", "**", "*.rb")) { |file| require file }
