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
            SELECT user AS schema_name FROM DUAL
        ), environment_details AS (
            SELECT SYS_CONTEXT('userenv','con_name') AS environment_name FROM DUAL
        )
        SELECT
            schema_details.schema_name as schema
            , environment_details.environment_name as environment
            , 'health_scheduled_job_details' AS source
            , JSON_OBJECT(
                'job_name' is user_scheduler_jobs.job_name
                , 'enabled' is user_scheduler_jobs.enabled
                , 'log_date' is coalesce(user_scheduler_job_run_details.log_date, null)
                , 'log_status' is coalesce(user_scheduler_job_run_details.status, 'never run')
                , 'run_duration' is to_char(user_scheduler_job_run_details.run_duration,'HH:MM:SS')
            ) AS message
            , systimestamp as log_time
        FROM
          schema_details
          , environment_details
          , user_scheduler_jobs
        LEFT JOIN user_scheduler_job_run_details ON
          1 = 1
          AND user_scheduler_jobs.job_name = user_scheduler_job_run_details.job_name
        WHERE
          user_scheduler_job_run_details.log_date IS NULL
          OR
          user_scheduler_job_run_details.log_date >= TRUNC(sysdate)
      SQL
    end
  end
end
