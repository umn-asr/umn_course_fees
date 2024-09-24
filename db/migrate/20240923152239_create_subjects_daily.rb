class CreateSubjectsDaily < ActiveRecord::Migration[7.0]
  def change
    create_view(:subjects_daily, materialized: true)
    add_index(:subjects_daily, [:id, :abbreviation, :term_id])
    schedule_refresh(
      :subjects_daily,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
