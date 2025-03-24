require 'tty-prompt'
require_relative 'music_collection'

class MusicCollectionManager
  def initialize(file_path = "music.yml")
    @file_path = file_path

    @music_collection = MusicCollection.new
    @music_collection.load_from_yaml(file_path)

    @prompt = TTY::Prompt.new
  end

  def run
    loop do
      choice = @prompt.select("\nChoose an option", %w[Add_Song Edit_Song Delete_Song Search_Song List_All Exit])

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

    @music_collection.save_to_yaml(@file_path)
  end

  private

  def add_song_prompt
    title = @prompt.ask("Enter the song title:")
    artists_str = @prompt.ask("Enter artists (comma separated):")
    genres_str = @prompt.ask("Enter genres (comma separated):")

    if title && !title.strip.empty? && artists_str && !artists_str.strip.empty?
      artists = artists_str.split(',').map(&:strip)
      genres = genres_str.split(',').map(&:strip)

      @music_collection.add_song(title, artists, genres)
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

    @music_collection.edit_song(title, artists, genres)
  end

  def delete_song_prompt
    title = @prompt.ask("Enter the song title:")

    @music_collection.delete_song(title)
  end

  def search_song_prompt
    keyword = @prompt.ask("Search:")
    result = @music_collection.search_song(keyword)
    @music_collection.output_collection(result)
  end

  def list_all_songs
    p "There no songs in collection" if @music_collection.songs.empty?
      
    @music_collection.output_collection
  end
end

if __FILE__ == $0
  manager = MusicCollectionManager.new
  manager.run
end

