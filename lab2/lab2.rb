require 'json'
require 'yaml'
require 'tty-prompt'

require_relative '../lab1/lab1'

music_collection = {}

def main
  # save_to_json(music_collection, "music.json")
  # save_to_yaml(music_collection, "music.yml")

  music_collection = load_from_yaml("music.yml")

  prompt = TTY::Prompt.new

  while true
    choice = prompt.select("Choose an option", %w[Add_Song Edit_Song Delete_Song Search_Song List_All Exit])

    case choice
    when "Add_Song"
      title = prompt.ask("Enter the song title:")
      artists_str = prompt.ask("Enter artists (comma separated):")
      genres_str = prompt.ask("Enter genres (comma separated):")

      if title && !title.strip.empty? && artists_str && !artists_str.strip.empty?
        artists = artists_str.split(',').map(&:strip)
        genres = genres_str.split(',').map(&:strip)
        
        add_song(music_collection, title, artists, genres)
      else
        puts "\nInvalid input: Both title and artists are required."
      end

    when "Edit_Song"
      title = prompt.ask("Enter the song title:")
      artists_str = prompt.ask("Enter artists (comma separated):")
      genres_str = prompt.ask("Enter genres (comma separated):")

      artists = artists_str.split(',').map(&:strip)
      genres = genres_str.split(',').map(&:strip)

      edit_song(music_collection, title, artists, genres)

    when "Delete_Song"
      title = prompt.ask("Enter the song title:")

      if music_collection.has_key?(title.to_sym)
        delete_song(music_collection, title)
      else
        puts "\nSong '#{title}' is not found."
      end

    when "Search_Song"
      keyword = prompt.ask("Search:")
      result = search_song(music_collection, keyword)
			output_collection(result)

		when "List_All"
			output_collection(music_collection)

    when "Exit"
      break
    else
      puts "\nInvalid option."
    end
  end

	save_to_yaml(music_collection, "music.yml")
end

main if __FILE__ == $0
