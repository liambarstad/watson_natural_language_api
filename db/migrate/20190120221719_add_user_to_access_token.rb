class AddUserToAccessToken < ActiveRecord::Migration[5.2]
  def change
    add_reference :access_tokens, :user, index: true, foreign_key: true
  end
end
