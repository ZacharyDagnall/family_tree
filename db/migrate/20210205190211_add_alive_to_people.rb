class AddAliveToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :alive, :boolean, default: true
  end
end
