require 'json'
require 'yaml'

music_collection = {}

def add_song(collection, title, artists, genres)
  collection[title.to_sym] = {artists: artists, genres: genres}
end

def edit_song(collection, title, new_artists: nil, new_genres: nil)
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
'''
add_song(music_collection, "Сподіваюсь, з тобою все гаразд", ["mistmorn"], ["post-punk"])
add_song(music_collection, "Небо", ["SadSvit"], ["post-punk"])
add_song(music_collection, "Танці", ["SadSvit", "Sad Novelist"], ["post-punk"])
add_song(music_collection, "сам собі наказ", ["хейтспіч", "Sad Novelist"], ["post-punk", "punk-rock"])
add_song(music_collection, "хвора на любов", ["vioria"], ["kitty-rock"])
add_song(music_collection, "То моє море", ["ВІКА"], ["synthpop"])
add_song(music_collection, "Black Catcher", ["VK Blanka"], ["pop"])
add_song(music_collection, "Мовчати", ["Ірина Білик", "Скрябін"], ["pop"])
add_song(music_collection, "Реквієм", ["postluv", "Sad Novelist", "Відчай"], ["pop"])
add_song(music_collection, "Десять причин", ["OTOY"], ["rap"])
add_song(music_collection, "Загублене літо", ["Electrobirds"], ["post-punk"])
add_song(music_collection, "Файна", ["Міша Правильний"], ["rap"])
add_song(music_collection, "Де Твоя Лінія", ["Лінія Маннергейма"], ["rock"])
add_song(music_collection, "30", ["DK Energetyk"], ["post-punk"])
add_song(music_collection, "Байдужий", ["Luna Rozza", "BaWN"], ["post-punk"])
add_song(music_collection, "Пластик", ["паліндром"], ["alt-rock", "post-punk"])
add_song(music_collection, "Тління", ["Sad Novelist"], [])
'''
delete_song(music_collection, "Black Catcher")

edit_song(music_collection, "Тління", new_artists: ["Sad Novelist", "SadSvit"], new_genres: ["post-punk"])

p search_song(music_collection, "То моє ")

# p music_collection


# save_to_json(music_collection, "music.json")
# save_to_yaml(music_collection, "music.yml")

music_collection = load_from_json("music.json")

p music_collection
p search_song(music_collection, "То моє ")
