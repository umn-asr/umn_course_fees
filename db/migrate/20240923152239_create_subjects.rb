class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_view(:subjects, materialized: true)
    add_index(:subjects, [:id, :abbreviation, :term_id])
    schedule_refresh(
      :subjects,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
