class Match < ActiveRecord::Base
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  belongs_to :map

  # def self.import
  #   csv = CSV.read("csv/history.csv", headers: true)
  #
  #   csv.by_row.each do |row|
  #     replay_id = row["ReplayID"].to_i
  #     next if Match.find_by(replay_id: replay_id)
  #
  #     match = Match.create(
  #       replay_id: replay_id,
  #       result
  #     )
  #     # if !Match.find_by(replay_id: row["ReplayID"].to_i)
  #     #   Match.create(
  #     #     replay_id: row["ReplayID"].to_i,
  #     #
  #     #   )
  #     # end
  #   end
  # end

end
