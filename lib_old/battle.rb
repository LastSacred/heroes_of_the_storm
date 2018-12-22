class Battle

  attr_reader :name, :player, :map_name, :hero_as, :heroes_with, :heroes_against, :win

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, player, map_name, hero_as, heroes_with, heroes_against, win)
    @name = name
    @player = player
    @map = Map.find_or_create(map_name)
    @hero_as = Hero.find_or_create(hero_as)
    @heroes_with = Hero.find_or_create_each(heroes_with)
    @heroes_against = Hero.find_or_create_each(heroes_against)
    @win = win
    self.class.all << self
  end

end
