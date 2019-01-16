class HeroPick < ActiveRecord::Base
  belongs_to :match
  belongs_to :hero
  # TODO: picked by will need to be populated with the battletag to support multiple users
end
