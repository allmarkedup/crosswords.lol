class AddUniqueContraintToCrosswordsNumber < ActiveRecord::Migration[8.0]
  def change
    add_index :crosswords, :number, unique: true
  end
end
