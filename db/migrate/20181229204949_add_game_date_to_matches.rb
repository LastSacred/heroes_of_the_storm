class AddGameDateToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :game_date, :string
  end
end
