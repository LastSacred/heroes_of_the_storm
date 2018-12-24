class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :battletag
      t.integer :last_import
      t.integer :region
    end
  end
end
