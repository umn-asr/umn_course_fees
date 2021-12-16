module DataViews
  class CourseFees < ViewBuilder::View
    def self.view_name
      "course_fees"
    end

    def self.definition_sql
      <<~SQL
        WITH tfms_data AS (
          SELECT
            fees.id fee_id,
            cached_courses.crse_id,
            cached_courses.subject,
            cached_courses.catalog_nbr as catalog_number,
            cached_courses.descr as class_name,
            fees.campus_code,
            courses.class_section as section,
            fee_categories.name as fee_description,
            rates.type as fee_type,
            rates.amount,
            courses.fall,
            courses.spring,
            courses.summer,
            fiscal_years.year
          FROM
            asr_tfms.courses
          LEFT JOIN asr_tfms.fee_occurrences
            ON courses.fee_occurrence_id=fee_occurrences.id
          LEFT JOIN asr_tfms.fees
            ON fee_occurrences.fee_id=fees.id
          LEFT JOIN asr_tfms.fee_dimensions
            ON fee_occurrences.id=fee_dimensions.fee_occurrence_id
          LEFT JOIN asr_tfms.fee_categories
            ON fee_dimensions.fee_category_id=fee_categories.id
          LEFT JOIN asr_tfms.rates
            ON fee_dimensions.id=rates.fee_dimension_id
          LEFT JOIN asr_tfms.fiscal_years
            ON fee_occurrences.fiscal_year_id=fiscal_years.id
          INNER JOIN asr_tfms.cached_courses
            ON courses.crse_id=cached_courses.crse_id
            AND courses.crse_offer_nbr=cached_courses.crse_offer_nbr
          INNER JOIN asr_tfms.revision_statuses
            ON fee_occurrences.revision_status_id = revision_statuses.id
          WHERE 1=1
            AND UPPER(revision_statuses.name) = 'CURRENT'
            AND asr_tfms.fee_occurrences.state in ('ready_for_sfit', 'ready_for_peoplesoft', 'fit_for_use')
            AND asr_tfms.fee_dimensions.assessment_method_id in (1)
            AND asr_tfms.fees.type='CourseClass'
            AND (
              asr_tfms.courses.class_section < '700'
              OR asr_tfms.courses.class_section >= '800'
              OR asr_tfms.courses.class_section is null
            )
        ),
        spring_courses AS (
            SELECT
              tfms_data.*,
              (year - 1900 || '3') as strm
            FROM
              tfms_data
            WHERE
              spring = 1
        ),
        summer_courses AS (
            SELECT
              tfms_data.*,
              (year - 1900 || '5') as strm
            FROM
              tfms_data
            WHERE
              summer = 1
        ),
        fall_courses AS (
            SELECT
              tfms_data.*,
              ((year - 1) - 1900 || '9') as strm
            FROM
              tfms_data
            WHERE
              fall = 1
        ),
        all_courses AS (
          select * from fall_courses
          UNION
          select * from summer_courses
          UNION
          select * from spring_courses
        )
        SELECT
          CAST(ORA_HASH(amount || fee_description || class_name || subject || strm || campus_code || fee_id) AS INTEGER) id,
          CAST(ORA_HASH(subject || strm || campus_code) AS INTEGER) subject_id,
          crse_id,
          class_name,
          catalog_number,
          section,
          fee_description,
          fee_type,
          amount
        FROM
          all_courses
        ORDER BY
          class_name, section
      SQL
    end
  end
end
