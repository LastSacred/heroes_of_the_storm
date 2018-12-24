class HeroPick < ActiveRecord::Base
  belongs_to :match
  belongs_to :hero
end
