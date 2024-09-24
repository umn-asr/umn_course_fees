SELECT
          strm,
          CAST(ora_hash(strm || campus_code) AS INTEGER) term_id
        FROM (
          SELECT
            DISTINCT CASE
              when fall = 1 then
                (fiscal_years.year - 1) - 1900 || '9'
              when spring = 1 then
                fiscal_years.year - 1900 || '3'
              when summer = 1 then
                fiscal_years.year -1900 || '5'
            end as strm,
            tfms_fees.campus_code
          FROM
            tfms_courses
          INNER JOIN
            tfms_fee_occurrences
          ON
            tfms_courses.fee_occurrence_id=tfms_fee_occurrences.id
          LEFT JOIN tfms_fees
            ON tfms_fee_occurrences.fee_id=tfms_fees.id
          LEFT JOIN
            tfms_fiscal_years
          ON
            tfms_fee_occurrences.fiscal_year_id=tfms_fiscal_years.id
          WHERE tfms_fee_occurrences.state
            IN ('ready_for_sfit', 'ready_for_peoplesoft', 'fit_for_use')
        ) term_codes
        WHERE
          term_codes.strm is not null
        ORDER BY
          strm