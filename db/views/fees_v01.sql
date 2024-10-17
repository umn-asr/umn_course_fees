SELECT
          CAST(ORA_HASH(course_id || course_fee_id || amount || fee_type || fee_description ||section ) AS INTEGER) id,
          course_id,
          amount,
          fee_type,
          fee_description,
          section
        FROM (
          SELECT
            CAST(ORA_HASH(crse_id || term_id || class_name) AS INTEGER) course_id,
            amount,
            course_fees.id course_fee_id,
            case fee_type
              when 'PerCredit' then 'Per Credit'
              else fee_type
            end fee_type,
            fee_description,
            COALESCE(section, 'All') section
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
        )