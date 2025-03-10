class AddEventsToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :events, :text
  end
end
