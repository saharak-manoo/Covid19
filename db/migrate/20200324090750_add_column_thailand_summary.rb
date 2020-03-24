class AddColumnThailandSummary < ActiveRecord::Migration[6.0]
  def change
    change_column :thailand_summaries, :confirmed, :integer, default: 0
    change_column :thailand_summaries, :confirmed_add_today, :integer, default: 0
    change_column :thailand_summaries, :healings, :integer, default: 0
    change_column :thailand_summaries, :recovered, :integer, default: 0
    change_column :thailand_summaries, :critical, :integer, default: 0
    change_column :thailand_summaries, :deaths, :integer, default: 0
    change_column :thailand_summaries, :watch_out_collectors, :integer, default: 0
    change_column :thailand_summaries, :new_watch_out, :integer, default: 0
    change_column :thailand_summaries, :case_management_admit, :integer, default: 0
    change_column :thailand_summaries, :case_management_discharged, :integer, default: 0
    change_column :thailand_summaries, :case_management_observation, :integer, default: 0
    change_column :thailand_summaries, :airport, :integer, default: 0
    change_column :thailand_summaries, :sea_port, :integer, default: 0
    change_column :thailand_summaries, :ground_port, :integer, default: 0
    change_column :thailand_summaries, :at_chaeng_wattana, :integer, default: 0

    add_column :thailand_summaries, :date, :date
  end
end
