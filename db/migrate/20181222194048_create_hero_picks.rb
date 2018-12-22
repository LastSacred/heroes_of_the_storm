class CreateHeroPicks < ActiveRecord::Migration[5.2]
  def change
    create_table :hero_picks do |t|
      t.string :picked_by
      t.integer :battle_id
      t.integer :hero_id
    end
  end
end
