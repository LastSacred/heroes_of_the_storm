class Map

  attr_reader :name

  @@all = []

  def self.all
    @@all
  end

  def self.find_from_name(name)
    self.all.find do |object|
      object.name == name
    end
  end

  def self.find_or_create(name)
    if !(object = self.find_from_name(name))
      object = self.new(name)
    end

    object
  end

  def initialize(name)
    @name = name
    self.class.all << self
  end

end
