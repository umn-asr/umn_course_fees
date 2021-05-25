module DataSnapshots
  class Fees < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "fees_daily"
    end

    def self.indexes
      %w[id course_id]
    end

    def self.definition_sql
      <<~SQL
        select * from #{DataViews::Fees.view_name}
      SQL
    end
  end
end
