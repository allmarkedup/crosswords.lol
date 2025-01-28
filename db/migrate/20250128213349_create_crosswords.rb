class CreateCrosswords < ActiveRecord::Migration[8.0]
  def change
    create_table :crosswords do |t|
      t.integer :number, null: false
      t.string :style, default: "quick"
      t.text :data, default: ""

      t.timestamps
    end
  end
end
