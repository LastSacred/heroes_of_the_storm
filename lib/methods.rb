def welcome_info
  puts ""
  puts "When typing names of heroes and maps, you don't have to type the whole name."
  puts "Type enough characters to make it unique. Spaces and special characters are ignored."
  puts "You may always go back by typing 'back' or exit by typing 'exit'"
end

def find_by_shorthand(objects)
  loop do
    input = gets.strip
    return "back" if input == "back"
    exit if input == "exit"

    result = objects.select do |object|
      object.name.downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input.downcase.gsub(/[^a-z]/,''))
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

def print_hero_list(list)
  list.each do |element|
    puts element.name.yellow
  end
end

def print_map_list(list)
  list.each do |element|
    puts element.name.green
  end
end

def mean(results)
  results.sum / results.count
end
