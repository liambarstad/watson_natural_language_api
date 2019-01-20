class ChangeUsernameToApiKey < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username, :string
    add_column :users, :api_key, :string
  end
end
