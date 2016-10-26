=begin
Term data for all campus/terms that have fees
This data needs to be at the campus level, but Peoplesoft stores term data at the institution level.
So we have to create duplicates of UMNTC terms and give them the UMNRO campus id. Otherwis Rochester will have no terms.
=end
module DataViews
  class Terms < ViewBuilder::View
    def self.view_name
      "terms"
    end

    def self.dependencies
      [DataViews::TermsWithFees]
    end

    def self.definition_sql
      <<~SQL
        WITH all_undergrad_terms AS (
          SELECT
            strm,
            institution,
            descr as name,
            term_begin_dt as begin_date,
            term_end_dt as end_date
          FROM
            #{Ps::TermTbl.table_name}
          WHERE
            acad_career = 'UGRD'
            and months_between(sysdate, term_end_dt) < 24
        ),
        institution_terms AS (
          SELECT
            all_undergrad_terms.*
          FROM
            #{DataViews::TermsWithFees.view_name} terms_with_fees
          LEFT JOIN
            all_undergrad_terms
          ON
            all_undergrad_terms.strm = terms_with_fees.strm
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
      SQL
    end
  end
end
