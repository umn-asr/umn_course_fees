class CreateCampusesDaily < ActiveRecord::Migration[7.0]
  def change
    create_view(:campuses_daily, materialized: true)
    add_index(:campuses_daily, [:campus, :id])
    schedule_refresh(
      :campuses_daily,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
