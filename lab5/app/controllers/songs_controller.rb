class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
    @artists = Artist.all
    @genres = Genre.all
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to songs_path, notice: "Song was successfully created."
    else
      @artists = Artist.all
      @genres = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, artist_ids: [], genre_ids: [])
  end
end
