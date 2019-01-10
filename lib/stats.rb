class Stats

  def by_overall
    puts ""
    puts "Heroes by overall performance"
    @stats.rank
  end

  def by_map
    puts ""
    puts "All maps"
    Printer.list(Map.all.order(:name))

    Printer.prompt("Select a map")

    input = ShortFind.object(Map.all)
    return if !input
    @stats.map = input

    puts ""
    puts "Heroes by performance on"
    puts input.name.green
    Printer.redline

    @stats.rank_on_map
  end

  def by_otherhero(relationship)
    puts ""
    puts "All heroes"
    Printer.list(Hero.all.order(:name))

    Printer.prompt("Select a hero")

    input = ShortFind.object(Hero.all)
    return if !input
    @stats.otherhero = input

    puts ""
    print "Heroes by performance"
    puts " with" if relationship == "teammate"
    puts " against" if relationship == "opponent"
    puts input.name.yellow
    Printer.redline

    @stats.rank_including_hero(relationship)
  end

  def by_map_and_other_hero(relationship)
    puts ""
    puts "All maps"
    Printer.list(Map.all.order(:name))

    Printer.prompt("Select a map")

    map = ShortFind.object(Map.all.order(:name))
    return if !map
    @stats.map = map

    puts ""
    puts "All heroes"
    Printer.list(Hero.all)

    Printer.prompt("Select a hero")

    otherhero = ShortFind.object(Hero.all)
    return if !otherhero
    @stats.otherhero = otherhero

    puts ""
    puts "Heroes by performance on"
    puts map.name.green

    print "and"
    puts " with" if relationship == "teammate"
    puts " against" if relationship == "opponent"
    puts otherhero.name.yellow
    Printer.redline

    @stats.rank_on_map_including_hero(relationship)
  end

  def main
    loop do
      @stats = Coach.new
      
      Printer.stats_options

      input = gets.strip
      Menu.new if input == "back"
      exit if input == "exit"

      case input
      when "1"
        by_overall
      when "2"
        by_map
      when "3"
        by_otherhero("teammate")
      when "4"
        by_otherhero("opponent")
      when "5"
        by_map_and_other_hero("teammate")
      when "6"
        by_map_and_other_hero("opponent")
      else
        Printer.invalid
      end
    end
  end

  def initialize
    Printer.welcome(self.class.name)
    main
  end

end
