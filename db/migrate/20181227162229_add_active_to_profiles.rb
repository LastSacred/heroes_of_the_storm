class AddActiveToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :active, :integer
  end
end
