class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string  :name, null: false
      t.string  :address, null: false
      t.string  :phone, null: false
      t.string  :estimated_examination_fees, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
    end
  end
end
