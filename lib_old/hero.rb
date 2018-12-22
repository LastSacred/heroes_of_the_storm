class Hero

  attr_reader :name
  attr_accessor :role

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

  def self.find_or_create_each(names)
    names.map do |name|
      self.find_or_create(name)
    end
  end

  def initialize(name)
    @name = name
    self.class.all << self
  end

end
