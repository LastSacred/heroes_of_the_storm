class Settings

  def welcome
    puts ""
    puts "Settings"
    welcome_info
  end

  def main_options
    puts ""
    puts "1. Change my battletag"
    puts "2. Change my region"
    puts "3. Manually set last import"
    puts "4. Change hero list settings"
  end

  def set_last_import
    puts ""
    puts "Enter number:"

    input = gets.strip
    Settings.new if input == "back"
    exit if input == "exit"

    PROFILE.last_import = input
    PROFILE.save
  end

  def display_hero_list
    puts ""
    puts "Current hero list"
    puts "Set to #{PROFILE.list_type}"
    puts "---------------------------".red
    puts ""
    @settings.rank
  end

  def change_hero_list_options
    puts ""

    if PROFILE.list_type == "auto"
      puts "1. Set hero list to manual"
    else
      puts "1. Set hero list to auto (includs all heroes you have played in imported data.)"
      puts "2. Add a hero to the list"
      puts "3. Remove a hero from the list"
      puts "4. Clear the list"
    end
  end
#FIXME: changing to auto doesn't work
#TODO: remove manually set last import
  def change_hero_list
    loop do
      display_hero_list
      change_hero_list_options

      input = gets.strip
      main if input == "back"
      exit if input == "exit"

      if PROFILE.list_type == "auto"
        case input
        when "1"
          PROFILE.list_type = "manual"
        else
          puts ""
          puts "Invalid selection. Try again."
        end
      else
        case input
        when "1"
          PROFILE.list_type = "auto"
        when "2"
          puts ""
          puts "Enter hero:"
          hero = ShortFind.object(Hero.all)
          return if !hero
          hero.on_list = 1
          hero.save
        when "3"
          puts ""
          puts "Enter hero:"
          hero = ShortFind.object(Hero.all)
          return if !hero
          hero.on_list = 0
          hero.save
        when "4"
          Hero.all.each do |hero|
            hero.on_list = 0
            hero.save
          end
        else
          puts ""
          puts "Invalid selection. Try again."
        end
      end
      @settings = Coach.new
    end
  end

  def main
    loop do
      main_options

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
        set_last_import
      when "4"
        change_hero_list
      else
        puts ""
        puts "Invalid selection. Try again."
      end
    end
  end

  def initialize
    welcome
    @settings = Coach.new
    main
  end

end
