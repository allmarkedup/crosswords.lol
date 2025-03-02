class AddCrosswordSlug < ActiveRecord::Migration[8.0]
  def change
    add_column :crosswords, :slug, :string
  end
end
