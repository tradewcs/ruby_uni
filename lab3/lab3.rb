require 'json'
require 'yaml'
require 'tty-prompt'

require_relative '../lab1/lab1'

class MusicCollectionManager
  def initialize(file_path = "music.yml")
    @file_path = file_path
    @music_collection = load_from_yaml(@file_path)
    @prompt = TTY::Prompt.new
  end

  def run
    loop do
      choice = @prompt.select("Choose an option", %w[Add_Song Edit_Song Delete_Song Search_Song List_All Exit])

      case choice
      when "Add_Song"
        add_song_prompt
      when "Edit_Song"
        edit_song_prompt
      when "Delete_Song"
        delete_song_prompt
      when "Search_Song"
        search_song_prompt
      when "List_All"
        list_all_songs
      when "Exit"
        break
      else
        puts "\nInvalid option."
      end
    end

    save_to_yaml(@music_collection, @file_path)
  end

  private

  def add_song_prompt
    title = @prompt.ask("Enter the song title:")
    artists_str = @prompt.ask("Enter artists (comma separated):")
    genres_str = @prompt.ask("Enter genres (comma separated):")

    if title && !title.strip.empty? && artists_str && !artists_str.strip.empty?
      artists = artists_str.split(',').map(&:strip)
      genres = genres_str.split(',').map(&:strip)

      add_song(@music_collection, title, artists, genres)
    else
      puts "\nInvalid input: Both title and artists are required."
    end
  end

  def edit_song_prompt
    title = @prompt.ask("Enter the song title:")
    artists_str = @prompt.ask("Enter artists (comma separated):")
    genres_str = @prompt.ask("Enter genres (comma separated):")

    artists = artists_str.split(',').map(&:strip)
    genres = genres_str.split(',').map(&:strip)

    edit_song(@music_collection, title, artists, genres)
  end

  def delete_song_prompt
    title = @prompt.ask("Enter the song title:")

    if @music_collection.has_key?(title.to_sym)
      delete_song(@music_collection, title)
    else
      puts "\nSong '#{title}' is not found."
    end
  end

  def search_song_prompt
    keyword = @prompt.ask("Search:")
    result = search_song(@music_collection, keyword)
    output_collection(result)
  end

  def list_all_songs
    output_collection(@music_collection)
  end

  def save_to_yaml(collection, file_path)
    File.write(file_path, collection.to_yaml)
  end

  def load_from_yaml(file_path)
    if File.exist?(file_path)
      YAML.load_file(file_path) || {}
    else
      {}
    end
  end

  def add_song(collection, title, artists, genres)
    collection[title.to_sym] = { artists: artists, genres: genres }
  end

  def edit_song(collection, title, artists, genres)
    if collection.has_key?(title.to_sym)
      collection[title.to_sym] = { artists: artists, genres: genres }
    else
      puts "\nSong '#{title}' is not found."
    end
  end

  def delete_song(collection, title)
    collection.delete(title.to_sym)
  end

  def search_song(collection, keyword)
    result = {}
    collection.each do |title, details|
      if title.to_s.downcase.include?(keyword.downcase) ||
         details[:artists].any? { |artist| artist.downcase.include?(keyword.downcase) } ||
         details[:genres].any? { |genre| genre.downcase.include?(keyword.downcase) }
        result[title] = details
      end
    end
    result
  end

  def output_collection(collection)
    if collection.empty?
      puts "\nNo songs found."
    else
      collection.each do |title, details|
        puts "\nTitle: #{title}"
        puts "Artists: #{details[:artists].join(', ')}"
        puts "Genres: #{details[:genres].join(', ')}"
        puts
      end
    end
  end
end

if __FILE__ == $0
  manager = MusicCollectionManager.new
  manager.run
end
