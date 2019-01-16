class Profile < ActiveRecord::Base
# TODO: associate with heroes to support heroes for multiple accounts, many to many through profile_heroes
# TODO: associate with matches, many to many through profile_matches and write #tracked_matches(game_type="HeroLeague", days=90)
# TODO: create a front end to add a new profile
# TODO: add active field to allow chaning active user
# TODO: add methods like Profile#matches_as_hero(hero)
# TODO: add custome #set_active to make self active and all other inactive

# USER = Profile.all.find { |profile| profile.active }
end
