class AddReplayIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :replay_id, :integer
  end
end
