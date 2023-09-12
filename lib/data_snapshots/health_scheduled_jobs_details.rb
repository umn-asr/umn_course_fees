# Health view for scheduled jobs
module DataSnapshots
  class HealthScheduledJobsDetails < SnapshotBuilder::Snapshot
    def self.snapshot_name
      "health_scheduled_jobs_details"
    end

    def self.frequency
      "FREQ=HOURLY;INTERVAL=1"
    end

    def self.definition_sql
      <<-SQL
        WITH schema_details AS (
            SELECT
                user AS schema_name
            FROM
                dual
        ), environment_details AS (
            SELECT
                sys_context('userenv', 'con_name') AS environment_name
            FROM
                dual
        )
        SELECT
            schema_details.schema_name                                      AS schema,
            environment_details.environment_name                            AS environment,
            '#{snapshot_name}'                                  AS source,
            JSON_OBJECT(
                    'job_name' IS user_scheduler_jobs.job_name,
                    'enabled' IS user_scheduler_jobs.enabled,
                    'log_date' IS coalesce(user_scheduler_job_run_details.log_date, NULL),
                    'log_status' IS coalesce(user_scheduler_job_run_details.status, 'never run'),
                    'run_duration' IS to_char(user_scheduler_job_run_details.run_duration, 'HH:MM:SS')
                )
            AS message,
            coalesce(user_scheduler_job_run_details.log_date, systimestamp) AS log_time
        FROM
            schema_details,
            environment_details, user_scheduler_jobs
            LEFT JOIN user_scheduler_job_run_details ON 1 = 1
                                                        AND user_scheduler_jobs.job_name = user_scheduler_job_run_details.job_name
        WHERE
            ( user_scheduler_job_run_details.log_date IS NULL
              OR user_scheduler_job_run_details.log_date >= (
                SELECT
                    from_tz(CAST(trunc(last_refresh_date, 'mi') AS TIMESTAMP),
                            (
                        SELECT
                            to_char(systimestamp, 'TZR')
                        FROM
                            dual
                    ))
                FROM
                    user_mviews
                WHERE
                    mview_name = '#{snapshot_name.upcase}'
            ) )
      SQL
    end
  end
end
