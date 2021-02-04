class CreateMarriages < ActiveRecord::Migration[6.1]
  def change
    create_table :marriages do |t|
      t.date :anni
      t.integer :husband_id
      t.integer :wife_id

      t.timestamps
    end
  end
end
