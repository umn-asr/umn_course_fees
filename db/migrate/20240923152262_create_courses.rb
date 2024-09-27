class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_view(:courses, materialized: true)
    add_index(:courses, [:id, :term_id, :subject_id])
    schedule_refresh(
      :courses,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
