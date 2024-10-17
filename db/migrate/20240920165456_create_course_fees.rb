class CreateCourseFees < ActiveRecord::Migration[7.0]
  def change
    create_view(:course_fees, materialized: true)
    schedule_refresh(
      :course_fees,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
