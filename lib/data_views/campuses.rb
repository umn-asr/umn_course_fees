=begin
Contains effective, active Campus details
The campus name comes from the Institution, because Campuses do not have complete names.
=end
module DataViews
  class Campuses < ViewBuilder::View
    def self.view_name
      "campuses"
    end

    def self.dependencies
      [DataViews::CutoffDate]
    end

    # rubocop:disable Metrics/MethodLength
    def self.definition_sql
      <<~SQL
      SELECT
        campuses.campus id,
        campuses.institution,
        campuses.campus,
        institutions.descrformal name
      FROM
        #{Ps::CampusTbl.table_name} campuses
      JOIN (
        SELECT
          institution,
          campus,
          max(effdt) effdt
        FROM
          #{Ps::CampusTbl.table_name}
        WHERE
          effdt < (select cutoff from #{DataViews::CutoffDate.view_name})
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
          #{Ps::InstitutionTbl.table_name} institutions
        JOIN (
          SELECT
            institution,
            campus,
            max(effdt) effdt
          FROM
            #{Ps::InstitutionTbl.table_name}
          WHERE
            effdt < (select cutoff from #{DataViews::CutoffDate.view_name})
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
      SQL
    end
    # rubocop:enable Metrics/MethodLength
  end
end
