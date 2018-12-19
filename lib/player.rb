class Player

  attr_reader :name

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def new_battle(name, map_name, hero_as, heroes_with, heroes_against)
    Battle.new(name, self, map_name, hero_as, heroes_with, heroes_against)
  end

  def battles
    Battle.all.select do |battle|
      battle.player == self
    end
  end

end
