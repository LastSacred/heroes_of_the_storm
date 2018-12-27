class AddOnListToHeroes < ActiveRecord::Migration[5.2]
  def change
    add_column :heroes, :on_list, :integer
  end
end
