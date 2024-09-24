class CreateFeesDaily < ActiveRecord::Migration[7.0]
  def change
    create_view(:fees_daily, materialized: true)
    add_index(:fees_daily, [:id, :course_id])
    schedule_refresh(
      :fees_daily,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
