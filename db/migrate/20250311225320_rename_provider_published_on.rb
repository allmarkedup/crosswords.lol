class RenameProviderPublishedOn < ActiveRecord::Migration[8.0]
  def change
    rename_column :crosswords, :provider_published_on, :published_at
  end
end
