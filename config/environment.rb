require 'bundler'
Bundler.require

# DB = {
#   conn: SQLite3::Database.net('db/personal_hots_coach.db')
# }
# DB[:conn].results_as_hash = true

# classes
require_relative "../lib/battle.rb"
require_relative "../lib/hero.rb"
require_relative "../lib/map.rb"
require_relative "../lib/player.rb"
# modules
