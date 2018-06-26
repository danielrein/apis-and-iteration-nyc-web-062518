#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
show_characters_list
character = get_character_from_user
show_character_movies(character)
show_character_movies_titles(character)
