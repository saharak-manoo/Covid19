class CreateInfectedProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :infected_provinces do |t|
      t.date :date
      t.string :name
      t.integer :infected, default: 0
      t.integer :man_total, default: 0
      t.integer :woman_total, default: 0
      t.integer :no_gender_total, default: 0

      t.timestamps
    end
  end
end
