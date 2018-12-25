class Hero < ActiveRecord::Base
  has_many :hero_picks
  has_many :matches, through: :hero_picks
  self.table_name = "heroes"
end
