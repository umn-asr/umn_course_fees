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
            subjects_daily.id subject_id,
            terms_daily.id term_id,
            class_name,
            catalog_number,
            subjects_daily.abbreviation,
            terms_daily.strm,
            campus_id
          FROM
            course_fees
          INNER JOIN
            subjects_daily
          ON
            course_fees.subject_id = subjects_daily.id
          INNER JOIN
            terms_daily
          ON
            subjects_daily.term_id = terms_daily.id
          ORDER BY
            campus_id,
            terms_daily.strm,
            subjects_daily.abbreviation,
            catalog_number