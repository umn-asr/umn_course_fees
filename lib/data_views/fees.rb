#   Fees for a course.
module DataViews
  class Fees < ViewBuilder::View
    def self.view_name
      "fees"
    end

    def self.dependencies
      [
        DataViews::CourseFees,
        DataViews::Subjects,
        DataViews::Terms
      ]
    end

    def self.definition_sql
      <<~SQL
        SELECT
          CAST(ORA_HASH(course_id || amount || fee_type || fee_description ||section ) AS INTEGER) id,
          course_id,
          amount,
          fee_type,
          fee_description,
          section
        FROM (
          SELECT
            CAST(ORA_HASH(crse_id || term_id || class_name) AS INTEGER) course_id,
            amount,
            case fee_type
              when 'PerCredit' then 'Per Credit'
              else fee_type
            end fee_type,
            fee_description,
            COALESCE(section, 'All') section
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
        )
      SQL
    end
  end
end
