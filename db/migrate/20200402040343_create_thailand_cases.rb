class CreateThailandCases < ActiveRecord::Migration[6.0]
  def change
    create_table :thailand_cases do |t|
      t.string  :place_name, null: false
      t.date    :date, null: false
      t.string  :status, null: false
      t.string  :note, null: false
      t.string  :source, null: false
      t.decimal :latitude, null: false, precision: 10, scale: 6
      t.decimal :longitude, null: false, precision: 10, scale: 6

      t.timestamps
    end
  end
end
