class CreateHealthScheduledJobsDetails < ActiveRecord::Migration[7.0]
  def change
    create_view(:health_scheduled_jobs_details, materialized: true)
    schedule_refresh(
      :health_scheduled_jobs_details,
      schedule: "FREQ=HOURY;INTERVAL=1"
    )
  end
end
