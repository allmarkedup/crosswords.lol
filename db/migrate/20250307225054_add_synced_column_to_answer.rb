class AddSyncedColumnToAnswer < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :synced_at, :datetime, default: nil, null: true
  end
end
