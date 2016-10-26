module DataSnapshots
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

require_relative "../config/initializers/data_snapshots"
require "snapshot_builder"
Dir.glob(File.join(File.dirname(__FILE__), "data_snapshots", "**", "*.rb")) { |file| require file }
