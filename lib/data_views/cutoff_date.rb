module DataViews
  class CutoffDate < ViewBuilder::View
    def self.view_name
      "cutoff_date"
    end

    def self.definition_sql
      <<~SQL
      SELECT
        sysdate as cutoff
      FROM
        DUAL
      SQL
    end
  end
end
