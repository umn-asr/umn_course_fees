class CreateTermsDaily < ActiveRecord::Migration[7.0]
  def change
    create_view(:terms_daily, materialized: true)
    add_index(:terms_daily, [:id, :campus_id, :strm])
    schedule_refresh(
      :terms_daily,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
