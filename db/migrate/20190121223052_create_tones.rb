class CreateTones < ActiveRecord::Migration[5.2]
  def change
    create_table :tones do |t|
      t.string :emotion

      t.timestamps
    end
  end
end
