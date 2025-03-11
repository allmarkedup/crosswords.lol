class AddNumberToCrosswords < ActiveRecord::Migration[8.0]
  def change
    add_column :crosswords, :number, :integer
  end
end
