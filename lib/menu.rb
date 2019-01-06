class Menu

  def main
    loop do
      Printer.menu_options

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
        Printer.invalid
      end
    end
  end

  def initialize
    if Profile.all.find { |profile| profile.active == 1 }
      Printer.welcome(self.class.name)
      main
    else
      #TODO: add multiple pofiles, and no active profile detection
    end
  end

end
