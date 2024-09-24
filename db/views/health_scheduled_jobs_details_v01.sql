     WITH latest_logs AS (
            SELECT
                job_name,
                MAX(log_date) AS log_date
            FROM
                user_scheduler_job_log
            GROUP BY
                job_name
        ), never_run AS (
            SELECT
                user_scheduler_jobs.job_name,
                JSON_OBJECT(
                        'job_name' IS user_scheduler_jobs.job_name,
                        'enabled' IS user_scheduler_jobs.enabled,
                        'log_date' IS NULL,
                        'log_status' IS 'never run',
                        'run_duration' IS NULL
                    )
                AS message,
                coalesce(user_scheduler_job_run_details.log_date, systimestamp) AS log_time
            FROM
                user_scheduler_jobs
                LEFT JOIN user_scheduler_job_run_details ON user_scheduler_jobs.job_name = user_scheduler_job_run_details.job_name
            WHERE
                user_scheduler_job_run_details.log_date IS NULL
        ), run_details AS (
            SELECT
                latest_logs.job_name,
                JSON_OBJECT(
                        'job_name' IS latest_logs.job_name,
                        'enabled' IS jobs.enabled,
                        'log_date' IS latest_logs.log_date,
                        'log_status' IS deets.status,
                        'run_duration' IS to_char(deets.run_duration, 'HH:MM:SS')
                    )
                AS message,
                latest_logs.log_date AS log_time
            FROM
                    user_scheduler_jobs jobs
                INNER JOIN latest_logs ON jobs.job_name = latest_logs.job_name
                INNER JOIN user_scheduler_job_log         logs ON latest_logs.job_name = logs.job_name
                                                          AND latest_logs.log_date = logs.log_date
                INNER JOIN user_scheduler_job_run_details deets ON logs.job_name = deets.job_name
                                                                  AND logs.log_id = deets.log_id
        )
        SELECT
            user                               AS schema,
            sys_context('userenv', 'con_name') AS environment,
            'health_scheduled_job_details'     AS source,
            combined.job_name,
            combined.message,
            combined.log_time
        FROM
            (
                SELECT
                    *
                FROM
                    never_run
                UNION
                SELECT
                    *
                FROM
                    run_details
            ) combined