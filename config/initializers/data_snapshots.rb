require "active_record"
include ActiveRecord::Tasks

DatabaseTasks.root = begin
  DataSnapshots.root
rescue NameError
  Rails.root
end

DatabaseTasks.env = begin
  DataSnapshots.environment
rescue NameError
  Rails.env
end

# DatabaseTasks.db_dir = File.join(DatabaseTasks.root, "/db")
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(DatabaseTasks.root, "config", "database.yml")))
# DatabaseTasks.migrations_paths = File.join(DatabaseTasks.db_dir, "migrations")
ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym

require "data_snapshots"
