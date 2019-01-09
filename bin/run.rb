require_relative "../config/environment.rb"


coach= Coach.new
ashero = Hero.find_by(name: "Artanis")
coach.map = Map.find(7)

binding.pry
