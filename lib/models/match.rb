class Match < ActiveRecord::Base
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  belongs_to :map
  # TODO: refactor to put ashero, withheroes, and againstheroes, getters in Match class
end
