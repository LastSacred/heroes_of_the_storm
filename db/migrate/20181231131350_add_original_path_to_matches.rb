class AddOriginalPathToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :original_path, :string
  end
end
