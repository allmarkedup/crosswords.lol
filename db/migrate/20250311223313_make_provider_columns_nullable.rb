class MakeProviderColumnsNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:crosswords, :provider_reference, true)
    change_column_null(:crosswords, :provider_name, true)
  end
end
