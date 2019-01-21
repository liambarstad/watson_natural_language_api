class AddLanguageForeignKeyToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_reference :feedbacks, :language, index: true, foreign_key: true
  end
end
