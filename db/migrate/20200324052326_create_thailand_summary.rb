class CreateThailandSummary < ActiveRecord::Migration[6.0]
  def change
    create_table :thailand_summaries do |t|
      t.integer :confirmed
      t.integer :healings
      t.integer :deaths
      t.integer :recovered
      t.integer :critical
      t.integer :confirmed_add_today
      t.integer :watch_out_collectors
      t.integer :new_watch_out
      t.integer :case_management_admit
      t.integer :case_management_discharged
      t.integer :case_management_observation
      t.integer :airport
      t.integer :sea_port
      t.integer :ground_port
      t.integer :at_chaeng_wattana

      t.timestamps
    end
  end
end
