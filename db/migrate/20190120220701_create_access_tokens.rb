class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.string :token

      t.timestamps
    end
  end
end
