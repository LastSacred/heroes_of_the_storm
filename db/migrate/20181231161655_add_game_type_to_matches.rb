class AddGameTypeToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :game_type, :string
  end
end
