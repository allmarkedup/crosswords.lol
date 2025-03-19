class RemoveUnusedCrosswordProviderColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :crosswords, :provider_name, :string
    remove_column :crosswords, :provider_reference, :string
  end
end
