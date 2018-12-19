require 'pry'

require_relative "../lib/battle.rb"
require_relative "../lib/hero.rb"
require_relative "../lib/map.rb"
require_relative "../lib/player.rb"

lastsacred = Player.new("LastSacred")

lastsacred.new_battle("battle1", "Hanamura Temple", "Li Li", ["Diablo", "Azmodan", "Varian", "Genji"], ["Garrosh", "Ana", "Raynor", "Jaina", "Zagara"])

binding.pry
