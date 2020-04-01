class DropHospitalsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :hospitals
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
