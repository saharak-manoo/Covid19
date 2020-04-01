class CreateHospitalsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string  :name, null: false
      t.string  :province, null: false
      t.string  :district, null: false
      t.string  :hospital_type, null: false, default: 'รพ.รัฐฯ'
      t.decimal :min_cost, null: false, precision: 8, scale: 2, default: 0
      t.decimal :max_cost, null: false, precision: 8, scale: 2, default: 0
      t.string  :phone_number, null: false
      t.decimal :latitude, null: false, precision: 10, scale: 6
      t.decimal :longitude, null: false, precision: 10, scale: 6

      t.timestamps
    end
  end
end
