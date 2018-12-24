class RemoveNameFromMatches < ActiveRecord::Migration[5.2]
  def change
    remove_column :matches, :name, :string
  end
end
