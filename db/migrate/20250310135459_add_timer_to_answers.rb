class AddTimerToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :timer, :text
  end
end
