class CreateCutoffDate < ActiveRecord::Migration[7.0]
  def change
    create_view(:cutoff_date, materialized: true)
    schedule_refresh(
      :cutoff_date,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
