 WITH all_undergrad_terms AS (
          SELECT
            CAST(ora_hash(strm || institution) AS INTEGER) term_id,
            strm,
            institution,
            descr as name,
            term_begin_dt as begin_date,
            term_end_dt as end_date
          FROM
            warehouse_cs_ps_term_tbl
          WHERE
            acad_career = 'UGRD'
            and months_between(sysdate, term_end_dt) < 24
        ),
        institution_terms AS (
          SELECT
            all_undergrad_terms.*
          FROM
            terms_with_fees
          LEFT JOIN
            all_undergrad_terms
          ON
            all_undergrad_terms.term_id = terms_with_fees.term_id
        ), rochester_terms as (
          select
            'UMNRO' as campus_id,
            strm,
            name,
            begin_date,
            end_date
          from
            institution_terms
          where
            institution = 'UMNTC'
        ), non_rochester_terms as (
          select
            institution as campus_id,
            strm,
            name,
            begin_date,
            end_date
          from
            institution_terms
        )
        SELECT
          CAST(ora_hash(term_data.strm || term_data.campus_id) AS INTEGER) id,
          term_data.*,
          CASE
            WHEN sysdate BETWEEN begin_date AND end_date
              THEN 'true'
              ELSE 'false'
          END AS current_term
        FROM (
          SELECT * from rochester_terms
          UNION
          SELECT * from non_rochester_terms
        ) term_data
        order by campus_id, strm