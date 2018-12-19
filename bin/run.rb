require_relative "../config/environment.rb"

lastsacred = Player.new("LastSacred")

battle1 = lastsacred.new_battle("battle1", "Hanamura Temple", "Li Li", ["Diablo", "Azmodan", "Varian", "Genji"], ["Garrosh", "Ana", "Raynor", "Jaina", "Zagara"], true)

binding.pry
