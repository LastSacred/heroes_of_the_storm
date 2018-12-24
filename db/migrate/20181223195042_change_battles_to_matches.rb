class ChangeBattlesToMatches < ActiveRecord::Migration[5.2]
  def change
    rename_table :battles, :matches
  end
end
