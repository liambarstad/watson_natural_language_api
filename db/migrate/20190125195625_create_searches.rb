class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :resource
      t.string :ip_address
      t.references :language, foreign_key: true, index: true
      t.references :tone, foreign_key: true, index: true

      t.timestamps
    end
  end
end
