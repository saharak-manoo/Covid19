class CreateWorlds < ActiveRecord::Migration[6.0]
  def change
    create_table :worlds do |t|
      t.string :country, null: false
      t.string :country_th, null: false
      t.string :country_flag, null: false
      t.string :travel, null: false
      t.integer :confirmed, null: false, default: 0
      t.integer :healings, null: false, default: 0
      t.integer :recovered, null: false, default: 0
      t.integer :deaths, null: false, default: 0

      t.timestamps
    end
  end
end
