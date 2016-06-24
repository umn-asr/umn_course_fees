=begin
Subjects offered by term.
The term_id reflects a campus' term, so these subjects are actually at the Campus/Term level.
=end
module DataViews
  class Subjects < ViewBuilder::View
    def self.view_name
      "subjects"
    end

    def self.dependencies
      [DataViews::Terms]
    end

    # rubocop:disable Metrics/MethodLength
    def self.definition_sql
      <<~SQL
      SELECT
        CAST(ORA_HASH(subject_id || strm || campus_id) AS INTEGER) id,
        CAST(ORA_HASH(strm || campus_id) AS INTEGER) term_id,
        abbreviation,
        name
      FROM (
        SELECT
          DISTINCT(classes.subject) abbreviation,
          classes.subject_descr name,
          classes.subject subject_id,
          classes.term strm,
          classes.campus campus_id
        FROM
          #{Ps::Dwsr::Class.table_name} classes
        INNER JOIN
          (
            select
              campus_id,
              strm
            from
              #{DataViews::Terms.view_name}
          ) current_terms
        ON
          current_terms.campus_id = classes.campus
          and current_terms.strm = classes.term
      )
      SQL
    end
    # rubocop:enable Metrics/MethodLength
  end
end
