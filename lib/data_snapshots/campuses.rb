module DataSnapshots
  class Campuses < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "campuses_daily"
    end

    def self.indexes
      %w[campus id]
    end

    def self.definition_sql
      <<~SQL
        select * from #{DataViews::Campuses.view_name}
      SQL
    end
  end
end
