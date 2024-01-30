# Model for application health checks
class HealthCheck
  def self.healthy?
    new.healthy?
  end

  def healthy?(sql: "SELECT 'ready' FROM DUAL")
    ActiveRecord::Base.connection.select_value(sql) == "ready"
  rescue
    false
  end
end
