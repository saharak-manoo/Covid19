class CreateGlobalSummary < ActiveRecord::Migration[6.0]
  def change
    create_table :global_summaries do |t|
      t.integer :confirmed
      t.integer :confirmed_add_today
      t.integer :healings
      t.integer :recovered
      t.integer :critical
      t.integer :deaths
      t.integer :deaths_add_today
      
      t.timestamps
    end
  end
end
