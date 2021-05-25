module DataSnapshots
  class Subjects < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "subjects_daily"
    end

    def self.indexes
      %w[id abbreviation term_id]
    end

    def self.definition_sql
      <<~SQL
        select * from #{DataViews::Subjects.view_name}
      SQL
    end
  end
end
