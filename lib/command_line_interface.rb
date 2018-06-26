def welcome
  puts "\nHello my dear friend. Welcome to the Star Wars API!\n\nplease enter a character from the following list:\n\n"
end

def get_character_from_user
  gets.chomp.downcase
end