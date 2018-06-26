require 'rest-client'
require 'json'
require 'pry'


def create_hash_from_api
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def show_characters_list
  names_array = create_hash_from_api["results"].map { | character_hash | character_hash["name"] }
  puts names_array
end

def get_character_info_from_api(character)
  create_hash_from_api["results"].find { |char| char["name"].downcase == character }
end

def get_character_movies_from_character_hash(character_hash)
  character_hash["films"].map do | film_url |
    RestClient.get(film_url)
  end    
end

def parse_films_array(films_array)
  films_array.map { | film | JSON.parse(film) }
end

def create_character_movies_array(character)
  create_hash_from_api
  character_hash = get_character_info_from_api(character)
  films_array = get_character_movies_from_character_hash(character_hash)
  parse_films_array(films_array)
end

def show_character_movies_array(character)
  puts create_character_movies_array(character)
end

def show_character_movies_titles(character)
  puts "\n\n\nThe films in which #{character} appeared are:\n"
  create_character_movies_array(character).each { |movie| puts movie["title"]}
end

def show_character_movies_info(films_array)

  films_parsed = parse_films_array(films_array)
  
  films_parsed.map do | film_hash |
    puts "\n\n\n\n***********************************\n\n\n\n"
    film_hash.keys.map do | key |
      puts "\n#{key}: #{film_hash[key]}"
    end
  end
end