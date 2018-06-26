require 'rest-client'
require 'json'
require 'pry'

def data_hash
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def characters_data
  data_hash["results"]
end

def character_names
  characters_data.map { | character_info | character_info["name"] }
end

def get_character_info(name)
  characters_data.find { | character_info | character_info["name"].downcase == name }
end

def get_character_films_urls(character_info)
  character_info["films"].map { | url | RestClient.get(url) }
end

def parse_array(array)
  array.map { | element | JSON.parse(element) }
end

def create_character_films_array(name)
  character_info = get_character_info(name)
  films = get_character_films_urls(character_info)
  parse_array(films)
end

def show_character_list
  puts character_names
end

def show_character_films_titles(character)
  puts "\n\n\nThe films in which #{character} appeared are:\n"
  create_character_films_array(character).each { |film| puts film["title"]}
end

def show_character_films_info(name)

  films = create_character_films_array(name)

  films.map do | film_hash |
    puts "\n\n\n\n***********************************\n\n\n\n"
    film_hash.keys.map do | key |
      puts "\n#{key}: #{film_hash[key]}"
    end
  end
end