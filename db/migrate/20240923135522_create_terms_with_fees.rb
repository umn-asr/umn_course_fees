class CreateTermsWithFees < ActiveRecord::Migration[7.0]
  def change
    create_view(:terms_with_fees, materialized: true)
    schedule_refresh(
      :terms_with_fees,
      schedule: "FREQ=DAILY;BYTIME=063000;BYDAY=MON,TUE,WED,THU,FRI,SAT"
    )
  end
end
