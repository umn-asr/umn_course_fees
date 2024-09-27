class CreateFees < ActiveRecord::Migration[7.0]
  def change
    create_view(:fees, materialized: true)
    add_index(:fees, [:id, :course_id])
    schedule_refresh(
      :fees,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
