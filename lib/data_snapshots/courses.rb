module DataSnapshots
  class Courses < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "courses_daily"
    end

    def self.indexes
      %w[id term_id subject_id]
    end

    def self.definition_sql
      <<~SQL
        select * from #{DataViews::Courses.view_name}
      SQL
    end
  end
end
