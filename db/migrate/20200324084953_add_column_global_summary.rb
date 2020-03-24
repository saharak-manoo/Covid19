class AddColumnGlobalSummary < ActiveRecord::Migration[6.0]
  def change
    change_column :global_summaries, :confirmed, :integer, default: 0
    change_column :global_summaries, :confirmed_add_today, :integer, default: 0
    change_column :global_summaries, :healings, :integer, default: 0
    change_column :global_summaries, :recovered, :integer, default: 0
    change_column :global_summaries, :critical, :integer, default: 0
    change_column :global_summaries, :deaths, :integer, default: 0
    change_column :global_summaries, :deaths_add_today, :integer, default: 0

    add_column :global_summaries, :date, :date
  end
end
