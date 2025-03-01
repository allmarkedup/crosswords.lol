class DropCrosswords < ActiveRecord::Migration[8.0]
  def up
    drop_table :crosswords
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
