require 'json'
require 'yaml'

class Song
  attr_accessor :title, :artists, :genres

  def initialize(title, artists, genres)
    @title = title
    @artists = artists
    @genres = genres
  end
end

class MusicCollection
  attr_accessor :songs

  def initialize
    @songs = []
  end

  def add_song(title, artists, genres)
    @songs << Song.new(title, artists, genres)
  end

  def edit_song(title, new_artists = nil, new_genres = nil)
    song = @songs.find { |s| s.title == title }
    return unless song

    song.artists = new_artists if new_artists
    song.genres = new_genres if new_genres
  end

  def delete_song(title)
    @songs.reject! { |s| s.title == title }
  end

  def search_song(keyword)
    @songs.select do |song|
      song.title.downcase.include?(keyword.downcase) ||
        song.artists.any?{ |artist| artist.downcase.include?(keyword.downcase) }
    end
  end


  def output_collection(songs = @songs)
    songs.each do |song|
      puts "\nSong: #{song.title}"
      puts "Artists: #{song.artists.join(', ')}"
      puts "Genres: #{song.genres.join(', ')}"
    end
  end

  def load_from_json(filename)
    data = JSON.parse(File.read(filename)) rescue []
    @songs = data.map { |song| Song.new(song['title'], song['artists'], song['genres']) }
  end

  def save_to_yaml(filename)
    data = @songs.map do |song|
      { 'title' => song.title, 'artists' => song.artists, 'genres' => song.genres }
    end
    File.write(filename, data.to_yaml)
  end

  def load_from_yaml(filename)
    data = YAML.load_file(filename) rescue {}

    @songs = data.map do |title, details|
      Song.new(title, details['artists'], details['genres'])
    end
  end

  def load_from_yaml(filename)
    data = YAML.load_file(filename) rescue []

    @songs = data.map do |song|
      Song.new(song['title'], song['artists'], song['genres'])
    end
  end

end

def main
  music = MusicCollection.new
  music.load_from_yaml("music.yml")
  
  p music.search_song("То моє ")
  p music.songs
end

main if __FILE__ == $0
