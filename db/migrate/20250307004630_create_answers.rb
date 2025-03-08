class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.belongs_to :account
      t.belongs_to :crossword
      t.text :values, null: false
      t.timestamps
    end
  end
end
