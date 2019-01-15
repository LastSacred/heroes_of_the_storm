class Draft

  def check_for_duplicates(result)
    if (@draft.withheroes + @draft.againstheroes + @draft.bans).include?(result)
      puts ""
      puts "Hero already selected".red
      puts "Try again"
      "back"
    else
      result
    end
  end

  def get_map
    Printer.prompt("Enter the map")

    input = ShortFind.object(Map.all)
    Menu.new if !input

    puts ""
    puts input.name.green
    Printer.redline

    input
  end

  def enter_ban
    Printer.prompt("Enter a banned hero")

    input = check_for_duplicates(ShortFind.object(Hero.all))
    return if !input

    @draft.bans << input
  end
  #TODO: combine enter teammate and enter opponent
  def enter_teammate
    Printer.prompt("Enter a teammate pick")

    input = check_for_duplicates(ShortFind.object(Hero.all))
    return if !input

    @draft.withheroes << input
  end

  def enter_opponent
    Printer.prompt("Enter an opponent pick")
    input = check_for_duplicates(ShortFind.object(Hero.all))
    return if !input
    @draft.againstheroes << input
  end

  def show_selections
    puts ""
    puts @draft.map.name.green

    puts ""
    puts "Bans"
    Printer.list(@draft.bans)

    puts ""
    puts "Team picks"
    Printer.list(@draft.withheroes)

    puts ""
    puts "Opponent picks"
    Printer.list(@draft.againstheroes)

    Printer.redline
  end

  def remove_hero
    Printer.prompt("Remove a hero entry")
    hero = ShortFind.object(Hero.all)
    return if !hero
    @draft.bans.delete(hero)
    @draft.withheroes.delete(hero)
    @draft.againstheroes.delete(hero)
  end

  def change_map
  Printer.prompt("Enter the map")
    input = ShortFind.object(Map.all)
    return if !input
    @draft.map = input
  end
  # FIXME: allow to go back directly from draft
  def main
    loop do
      @draft.rank_in_draft

      Printer.draft_options

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
      when "5"
        Draft.new
      else
        Printer.invalid
      end
      show_selections
    end
  end

  def initialize
    Printer.welcome(self.class.name)
    @draft = Coach.new(map: get_map, withheroes: [], againstheroes: [], bans: [])
    main
  end

end
