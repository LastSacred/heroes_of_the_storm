class Settings

  def display_hero_list
    puts ""
    puts "Current hero list"
    puts "Set to #{PROFILE.list_type}"
    Printer.redline
    @settings.rank
  end

  def add_remove_hero(symbol)
    if symbol == :add
      setting = 1
    elsif symbol == :remove
      setting = 0
    end

    Printer.prompt("Enter a hero")

    hero = ShortFind.object(Hero.all)
    return if !hero

    hero.on_list = setting
    hero.save
  end

  def change_hero_list
    loop do
      display_hero_list
      Printer.hero_list_options

      input = gets.strip
      main if input == "back"
      exit if input == "exit"

      if PROFILE.list_type == "auto"
        case input
        when "1"
          PROFILE.list_type = "manual"
        else
          Printer.invalid
        end
      else
        case input
        when "1"
          PROFILE.list_type = "auto"
        when "2"
        add_remove_hero(:add)
        when "3"
        add_remove_hero(:remove)
        when "4"
          Hero.all.each do |hero|
            hero.on_list = 0
            hero.save
          end
        else
          Printer.invalid
        end
      end
      @settings = Coach.new
    end
  end

  def main
    loop do
      Printer.settings_options

      input = gets.strip
      Menu.new if input == "back"
      exit if input == "exit"

      case input
      when "1"
        #TODO: change_battletag
        puts "This feature is not available yet"
      when "2"
        #TODO: change_region
        puts "This feature is not available yet"
      when "3"
        change_hero_list
      else
        Printer.invalid
      end
    end
  end

  def initialize
    Printer.welcome(self.class.name)
    @settings = Coach.new
    main
  end

end
