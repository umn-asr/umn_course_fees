# Term data for terms that have course fees.
module DataViews
  class TermsWithFees < ViewBuilder::View
    def self.view_name
      "terms_with_fees"
    end

    def self.definition_sql
      <<~SQL
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
            asr_tfms.fees.campus_code
          FROM
            asr_tfms.courses
          INNER JOIN
            asr_tfms.fee_occurrences
          ON
            courses.fee_occurrence_id=fee_occurrences.id
          LEFT JOIN asr_tfms.fees
            ON fee_occurrences.fee_id=fees.id
          LEFT JOIN
            asr_tfms.fiscal_years
          ON
            fee_occurrences.fiscal_year_id=fiscal_years.id
          WHERE asr_tfms.fee_occurrences.state
            IN ('ready_for_sfit', 'ready_for_peoplesoft', 'fit_for_use')
        ) term_codes
        WHERE
          term_codes.strm is not null
        ORDER BY
          strm
      SQL
    end
  end
end
