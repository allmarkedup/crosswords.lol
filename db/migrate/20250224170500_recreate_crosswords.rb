class RecreateCrosswords < ActiveRecord::Migration[8.0]
  def change
    create_table :crosswords do |t|
      t.string :crossword_type, default: "quick"
      t.integer :column_count, null: false
      t.integer :row_count, null: false
      t.text :entries, null: false
      t.string :provider_name, null: false
      t.string :provider_reference, null: false
      t.datetime :provider_published_on

      t.timestamps
    end
  end
end
