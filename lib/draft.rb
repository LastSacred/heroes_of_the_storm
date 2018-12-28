class Draft

  def check_for_duplicates(result)
    if (@draft.withheroes + @draft.againstheroes + @draft.bans).include?(result)
      puts ""
      puts "Hero already selected. Try again."
      "back"
    else
      result
    end
  end

  def welcome
    puts ""
    puts "Starting Draft Coach"
    welcome_info
  end

  def get_map
    puts ""
    puts "Enter map:"
    input = find_by_shorthand(Map.all)

    Menu.new if input == "back"

    puts ""
    puts input.name.green
    puts "---------------------------".red
    puts ""

    input
  end

  def main_options
    puts ""
    puts "What would you like to do?"
    puts "1. Enter a banned hero"
    puts "2. Enter a teammate pick"
    puts "3. Enter an opponent pick"
    puts "4. Remove a hero entry"
    #TODO: new draft option
  end

  def enter_ban
    puts ""
    puts "Enter a banned hero:"
    input = check_for_duplicates(find_by_shorthand(Hero.all))
    return if input == "back"
    @draft.bans << input
  end

  def enter_teammate
    puts ""
    puts "Enter a teammate pick:"
    input = check_for_duplicates(find_by_shorthand(Hero.all))
    return if input == "back"
    @draft.withheroes << input
  end

  def enter_opponent
    puts ""
    puts "Enter a opponent pick:"
    input = check_for_duplicates(find_by_shorthand(Hero.all))
    return if input == "back"
    @draft.againstheroes << input
  end

  def show_selections
    puts ""
    puts @draft.map.name.green

    puts ""
    puts "Bans"
    print_hero_list(@draft.bans)

    puts ""
    puts "Team picks"
    print_hero_list(@draft.withheroes)

    puts ""
    puts "Opponent picks"
    print_hero_list(@draft.againstheroes)

    puts "---------------------------".red
    puts ""
  end

  def remove_hero
    puts ""
    puts "Remove a hero entry:"
    hero = find_by_shorthand(Hero.all)
    return if hero == "back"
    @draft.bans.delete(hero)
    @draft.withheroes.delete(hero)
    @draft.againstheroes.delete(hero)
  end

  def change_map
    puts ""
    puts "Enter map:"
    input = find_by_shorthand(Map.all)
    return if input =="back"
    @draft.map = input
  end

  def main
    loop do
      @draft.rank_in_draft

      main_options

      input = gets.strip
      change_map if input == "back"
      exit if input == "exit"

      case input
      when "1"
        enter_ban
      when "2"
        enter_teammate
      when "3"
        enter_opponent
      when "4"
        remove_hero
      else
        puts ""
        puts "Invalid selection. Try again."
      end
      show_selections
    end
  end

  def initialize
    welcome
    @draft = Coach.new(map: get_map, withheroes: [], againstheroes: [], bans: [])
    main
  end

end
