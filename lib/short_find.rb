class ShortFind
  @@back = false
  @@exit = false

  def self.use_back(boolean)
    @@back = boolean
  end

  def self.use_exit(boolean)
    @@exit = boolean
  end

  def self.outs(boolean)
    @@back = boolean
    @@exit = boolean
  end

  def self.object(objects, attr="name")
    loop do
      input = get_input
      return if !input && @@back

      result = objects.select do |object|
        object.public_send(attr).downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input.downcase.gsub(/[^a-z]/,''))
      end

      output = test_result(result)
      return output if output
    end
  end

  def self.array_element(array)
    loop do
      input = get_input
      return if !input && @@back

      result = array.select do |element|
        element.downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input.downcase.gsub(/[^a-z]/,''))
      end

      output = test_result(result)
      return output if output
    end
  end

  def self.hash_element(hash, by="value")
    loop do
      input = get_input
      return if !input && @@back

      result = hash.select do |key, value|
        if by == "key"
          key.downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input.downcase.gsub(/[^a-z]/,''))
        elsif by == "value"
          value.downcase.gsub('ú', 'u').gsub(/[^a-z]/,'').start_with?(input.downcase.gsub(/[^a-z]/,''))
        end
      end

      output = test_result(result)
      return output if output
    end
  end

  private

  def self.get_input
    input = gets.strip
    return if input == "back" && @@back
    exit if input == "exit" && @@exit
    input
  end

  def self.test_result(result)
    if result.count == 0
      puts ""
      puts "No match found"
      puts "Try again"
    elsif result.count == 1
        return result[0]
    else
      puts ""
      puts "Multiple matches found"
      puts ""
      result.each { |result| puts result.name }
      puts ""
      puts "Try again"
    end
  end

end
