class Draft

  def find_by_shorthand(objects)
    loop do
      input = gets.strip
      return "back" if input == "back"
      exit if input == "exit"

      result = objects.select do |object|
        object.name.downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input)
      end
      if result.count == 0
        puts ""
        puts "No match found. Try again."
      elsif result.count ==1
          return result[0]
      else
        puts ""
        puts "Multiple matches found"
        result.each { |result| puts result.name.yellow }
        puts "Try again."
      end
    end

  end

  def check_for_duplicates(result)
    if (@draft.withheroes + @draft.againstheroes + @draft.bans).include?(result[0])
      puts ""
      puts "Hero already selected. Try again."
    else
      result
    end
  end

  def welcome
    puts ""
    puts "Starting Draft Coach"
    puts ""
    puts "When typing names of heroes and maps type all lower case with no"
    puts "spaces or special characters. Type enough characters to make it unique."
    puts "you may always go back by typing 'back' or exit by typing 'exit'"
  end

  def get_map
    puts ""
    puts "Enter map:"
    input = find_by_shorthand(Map.all)

    puts ""
    puts input.name.green
    puts "---------------------------".red
    puts ""

    go = Draft.new if input == "back"
    input
  end

  def main_options
    puts ""
    puts "What would you like to do?"
    puts "1. Enter a banned hero"
    puts "2. Enter a teammate pick"
    puts "3. Enter an opponent pick"
    puts "4. Remove a hero entry"
  end

  def enter_ban
    puts ""
    puts "Enter a banned hero"
    input = find_by_shorthand(Hero.all)
    return if input == "back"
    @draft.bans << check_for_duplicates(input)
  end

  def enter_teammate
    puts ""
    puts "Enter a teammate pick:"
    input = find_by_shorthand(Hero.all)
    return if input == "back"
    @draft.withheroes << check_for_duplicates(input)
  end

  def enter_opponent
    puts ""
    puts "Enter a opponent pick:"
    input = find_by_shorthand(Hero.all)
    return if input == "back"
    @draft.againstheroes << check_for_duplicates(input)
  end

  def print_list(list)
    list.each do |hero|
      puts hero.name.yellow
    end
  end

  def show_selections
    puts ""
    puts @draft.map.name.green

    puts ""
    puts "Bans"
    print_list(@draft.bans)

    puts ""
    puts "Team picks"
    print_list(@draft.withheroes)

    puts ""
    puts "Opponent picks"
    print_list(@draft.againstheroes)

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
