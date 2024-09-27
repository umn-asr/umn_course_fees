class CreateCampuses < ActiveRecord::Migration[7.0]
  def change
    create_view(:campuses, materialized: true)
    add_index(:campuses, [:campus, :id])
    schedule_refresh(
      :campuses,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
