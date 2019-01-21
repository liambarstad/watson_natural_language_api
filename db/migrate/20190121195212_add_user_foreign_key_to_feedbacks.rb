class AddUserForeignKeyToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_reference :feedbacks, :user, index: true, foreign_key: true
  end
end
