class AddCompletedAtToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :completed_at, :datetime, default: nil, null: true
  end
end
