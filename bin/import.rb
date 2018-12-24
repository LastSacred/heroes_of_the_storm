require_relative "../config/environment.rb"
# array = CSV.read("csv/history.csv", headers: true)
# array.by_row.each do |row|
#   puts row["Hero"]
# end
Import.new

puts "Import Complete"

binding.pry
