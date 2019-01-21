class AddToneForeignKeyToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_reference :feedbacks, :tone, index: true, foreign_key: true
  end
end
