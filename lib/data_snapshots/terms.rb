module DataSnapshots
  class Terms < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "terms_daily"
    end

    def self.indexes
      %w[id campus_id strm]
    end

    def self.definition_sql
      <<~SQL
        select * from #{DataViews::Terms.view_name}
      SQL
    end
  end
end
