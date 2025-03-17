require 'json'
require 'yaml'

music_collection = {}

def add_song(collection, title, artists, genres)
	collection[title.to_sym] = {artists: artists, genres: genres}
end

def edit_song(collection, title, new_artists, new_genres)
	return if !collection.key?(title.to_sym)
	
	if !new_artists.nil?
		collection[title.to_sym][:artists] = new_artists
	end

	if !new_genres.nil?
		collection[title.to_sym][:genres] = new_genres
	end
end

def delete_song(collection, title)
	collection.delete(title.to_sym)
end

def search_song(collection, keyword)
	collection.select { |title, details| title.to_s.include?(keyword) || details[:artists].any? { |artist| artist.include?(keyword) } }
end

def save_to_json(collection, filename)
	File.write(filename, JSON.pretty_generate(collection))
end

def load_from_json(filename)
	JSON.parse(File.read(filename), symbolize_names: true) rescue {}
end

def save_to_yaml(collection, filename)
	File.write(filename, collection.to_yaml)
end

def load_from_yaml(filename)
	YAML.load_file(filename, symbolize_names: true) rescue {}
end

def main
	# save_to_json(music_collection, "music.json")
	# save_to_yaml(music_collection, "music.yml")

	music_collection = load_from_json("music.json")

	p search_song(music_collection, "То моє ")

        p music_collection 
end

main if __FILE__ == $0
