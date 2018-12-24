class RenameBattleIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :hero_picks, :battle_id, :match_id
  end
end
