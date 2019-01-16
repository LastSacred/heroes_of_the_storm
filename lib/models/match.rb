class Match < ActiveRecord::Base
  has_many :hero_picks
  has_many :heroes, through: :hero_picks
  belongs_to :map
  # TODO: refactor to put ashero, withheroes, and againstheroes, getters in Match class based on the active
  # TODO: use accepts_nested_attributes_for and try to use in import? maybe not?
  # TODO: add AR Lifecycle Callbacks and validation, validates uniqueness, presence, etc. ,validate heros.count
      # validates :name, uniqueness: true (forces the name to be unique)
      # scope can be added
end
