#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
show_character_list
name = get_character_from_user
# show_character_films_info(name)
show_character_films_titles(name)
