require "scenic/oracle_adapter"
Scenic.configure do |config|
  config.database = Scenic::Adapters::Oracle.new
end
require "scheduled_refresh"
