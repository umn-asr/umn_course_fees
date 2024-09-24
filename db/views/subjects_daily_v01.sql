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
         warehouse_dwsr_class classes
          INNER JOIN
            (
              select
                campus_id,
                strm
              from
               terms_daily
            ) current_terms
          ON
            current_terms.campus_id = classes.campus
            and current_terms.strm = classes.term
    )