class Match < ActiveRecord::Base
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  belongs_to :map
end
