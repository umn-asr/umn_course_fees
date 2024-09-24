class CreateCoursesDaily < ActiveRecord::Migration[7.0]
  def change
    create_view(:courses_daily, materialized: true)
    add_index(:courses_daily, [:id, :term_id, :subject_id])
    schedule_refresh(
      :courses_daily,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
