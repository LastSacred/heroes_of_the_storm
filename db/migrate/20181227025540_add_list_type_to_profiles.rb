class AddListTypeToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :list_type, :text
  end
end
