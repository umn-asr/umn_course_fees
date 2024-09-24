SELECT
          campuses.campus id,
          campuses.institution,
          campuses.campus,
          institutions.descrformal name
        FROM
          warehouse_cs_ps_campus_tblcampuses
          
        JOIN (
          SELECT
            institution,
            campus,
            max(effdt) effdt
          FROM
            warehouse_cs_ps_campus_tbl
          WHERE
            effdt < (select cutoff from cutoff_dates)
          GROUP BY
            institution,
            campus
        ) effective_campuses
        ON
          effective_campuses.institution = campuses.institution
          and effective_campuses.campus  = campuses.campus
          and effective_campuses.effdt   = campuses.effdt
        JOIN (
          SELECT
            institutions.institution,
            institutions.descrformal
          FROM
            warehouse_cs_ps_institution_tbl institutions
          JOIN (
            SELECT
              institution,
              campus,
              max(effdt) effdt
            FROM
              warehouse_cs_ps_institution_tbl
            WHERE
              effdt < (select cutoff from cutoff_dates)
            GROUP BY
              institution, campus
          ) effective_institutions
          ON
            effective_institutions.institution = institutions.institution
            and effective_institutions.campus  = institutions.campus
            and effective_institutions.effdt   = institutions.effdt
          WHERE
            institutions.eff_status = 'A'
        ) institutions
        ON
          institutions.institution = campuses.institution
        WHERE
          campuses.eff_status = 'A'