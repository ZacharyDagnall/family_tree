class CreateFilials < ActiveRecord::Migration[6.1]
  def change
    create_table :filials do |t|
      t.date :anni
      t.integer :child_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
