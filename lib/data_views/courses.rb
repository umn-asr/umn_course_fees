=begin
  Courses with fees. One row per course in a Term
  Sorted so that courses appear in Subject/Catalog order by Term
=end
module DataViews
  class Courses < ViewBuilder::View
    def self.view_name
      "courses"
    end

    def self.dependencies
      [
        DataViews::CourseFees,
        DataViews::Subjects,
        DataViews::Terms,
      ]
    end

    def self.definition_sql
      <<~SQL
      SELECT
        CAST(ORA_HASH(crse_id || term_id || class_name ) AS INTEGER) id,
        subject_id,
        term_id,
        crse_id,
        class_name,
        catalog_number
      FROM (
        SELECT
          DISTINCT(crse_id) crse_id,
          subjects.id subject_id,
          terms.id term_id,
          class_name,
          catalog_number,
          subjects.abbreviation,
          terms.strm,
          campus_id
        FROM
          #{DataViews::CourseFees.view_name} course_fees
        INNER JOIN
          #{DataViews::Subjects.view_name} subjects
        ON
          course_fees.subject_id = subjects.id
        INNER JOIN
          #{DataViews::Terms.view_name} terms
        ON
          subjects.term_id = terms.id
        ORDER BY
          campus_id,
          terms.strm,
          subjects.abbreviation,
          catalog_number
      )
      SQL
    end
  end
end
