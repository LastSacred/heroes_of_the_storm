class Menu

  def welcome
    puts ""
    puts "Hello again #{BATTLETAG.split("#")[0]}, I'm your Personal HotS Coach."
    welcome_info
  end

  def main_options
    puts ""
    puts "What would you like to do?"
    puts "1. Start Draft Coach"
    puts "2. Start Stats Coach"
    puts "3. Start Import"
    puts "4. Change profile settings"
  end

  def main
    loop do
      main_options

      input = gets.strip
      Menu.new if input == "back"
      exit if input == "exit"

      case input
      when "1"
        Draft.new
      when "2"
        Stats.new
      when "3"
        Import.new
      when "4"
        Settings.new
      else
        puts ""
        puts "Invalid selection. Try again."
      end
    end
  end

  def initialize
    if Profile.all.find { |profile| profile.active == 1 }
      welcome
      main
    else
      #TODO: add multiple pofiles, and no active profile detection
    end
  end

end
