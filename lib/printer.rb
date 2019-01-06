module Printer

  def self.welcome(location)
    puts ""

    case location
    when "Menu"
      puts "Hello again #{BATTLETAG.split("#")[0]}, I'm your Personal HotS Coach.".yellow
    when "Stats"
      puts "Starting Stats Coach".green
    when "Draft"
      puts "Starting Draft Coach".red
    when "Settings"
      puts "Settings".magenta
    end

    welcome_info
  end

  def self.prompt(text=nil)
    puts ""
    puts text if text
    print "-> ".magenta
  end

  def self.invalid
    puts ""
    puts "Invalid selection".red
    puts "Try again"
  end

  def self.draft_options
    options = [
      "Enter a banned hero",
      "Enter a teammate pick",
      "Enter an opponent pick",
      "Remove a hero entry",
      "Start a new draft"
    ]

    list_options(options)
  end

  def self.menu_options
    options = [
      "Start Draft Coach",
      "Start Stats Coach",
      "Start Import",
      "Change profile settings"
    ]

    list_options(options)
  end

  def self.settings_options
    options = [
      "Change my battletag",
      "Change my region",
      "Change hero list settings"
    ]

    list_options(options)
  end

  def self.hero_list_options
    if PROFILE.list_type == "auto"
      options = [
        "Set hero list to manual"
      ]
    else
      options = [
        "Set hero list to auto (includs all heroes you have played in imported data.)",
        "Add a hero to the list",
        "Remove a hero from the list",
        "Clear the list"
      ]
    end

    list_options(options)
  end

  def self.stats_options
    options = [
      "List my heroes by overall performance",
      "List my heroes by performance on a particular map",
      "List my heroes by performance with a partuclar teammate hero",
      "List my heroes by performance against a partuclar opponent hero",
      [
        "List my heroes by performance on a particular map and",
        "with a particular teammate hero",
        "against a partuclar opponent hero"
      ]
    ]

    list_options(options)
  end

  def self.redline
    puts "---------------------------".red
    puts ""
  end

  def self.list(list)
    case list.first.class.name
    when "Map"
      color = "green"
    when "Hero"
      color = "yellow"
    else
      color = "white"
    end

    list.each do |element|
      puts element.name.public_send(color)
    end
  end

  def self.rank_list(list)
    list.sort_by { |hero, score| score }.each do |hero, score|
      puts score.to_s.blue + "   " + hero.role.cyan + "   " + hero.name.yellow
    end
  end

  private

  def self.welcome_info
    puts ""
    puts "When typing names of heroes and maps, you don't have to type the whole name."
    puts "Type enough characters to make it unique. Spaces and special characters are ignored."
    puts "You can always go back by typing 'back' or exit by typing 'exit'"
  end

  def self.list_options(options)
    puts ""
    puts "What would you like to do?"

    options.each_with_index do |option, index|
      if option.class == String
        puts (index + 1).to_s.light_blue + "  #{option}"
      else
        option.each_with_index do |subitem, subindex|
          if subindex == 0
            puts ""
            puts subitem
          else
            puts (index + subindex).to_s.light_blue + "  #{subitem}"
          end
        end
      end
    end
    prompt
  end

end
