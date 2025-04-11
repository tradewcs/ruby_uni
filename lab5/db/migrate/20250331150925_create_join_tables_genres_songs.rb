class CreateJoinTablesGenresSongs < ActiveRecord::Migration[8.0]
  def change
    create_join_table :genres, :songs do |t|
        t.index :genre_id
        t.index :song_id
    end
  end
end
