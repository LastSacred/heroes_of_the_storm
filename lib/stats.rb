class Stats

  def welcome
    puts ""
    puts "Starting Stats Coach"
    welcome_info
  end

  def main_options
    puts ""
    puts "What would you like to do?"
    puts "1. List my heroes by overall performance"
    puts "2. List my heroes by performance on a particular map"
    puts "3. List my heroes by performance with a partuclar teammate hero"
    puts "4. List my heroes by performance against a partuclar opponent hero"
    puts ""
    puts "List my heroes by performance on a particular map and"
    puts "5. with a particular teammate hero"
    puts "6. against a partuclar opponent hero"
  end

  def by_overall
    puts ""
    puts "Heroes by overall performance"
    @stats.rank
  end

  def by_map
    puts ""
    puts "All maps"
    print_map_list(Map.all.order(:name))

    puts ""
    puts "Enter map:"

    input = ShortFind.object(Map.all)
    return if !input
    @stats.map = input

    puts ""
    puts "Heroes by performance on"
    puts input.name.green
    puts "---------------------------".red
    puts ""

    @stats.rank_on_map
  end

  def by_otherhero(relationship)
    puts ""
    puts "All heroes"
    print_hero_list(Hero.all.order(:name))

    puts ""
    puts "Enter hero:"

    input = ShortFind.object(Hero.all)
    return if !input
    @stats.otherhero = input

    puts ""
    print "Heroes by performance"
    puts " with" if relationship == "teammate"
    puts " against" if relationship == "opponent"
    puts input.name.yellow
    puts "---------------------------".red
    puts ""

    @stats.rank_including_hero(relationship)
  end

  def by_map_and_other_hero(relationship)
    puts ""
    puts "All maps"
    print_map_list(Map.all.order(:name))

    puts ""
    puts "Enter map:"

    map = ShortFind.object(Map.all.order(:name))
    return if !map
    @stats.map = map

    puts ""
    puts "All heroes"
    print_hero_list(Hero.all)

    puts ""
    puts "Enter hero:"

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
    puts "---------------------------".red
    puts ""

    @stats.rank_on_map_including_hero(relationship)
  end

  def main
    loop do
      main_options

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
        puts ""
        puts "Invalid selection. Try again."
      end
    end
  end

  def initialize
    welcome
    @stats = Coach.new
    main
  end

end
