class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :key, null: false
      t.timestamps
    end
  end
end
