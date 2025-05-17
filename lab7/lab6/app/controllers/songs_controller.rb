class SongsController < ApplicationController
  include SearchSortable

  def index
    @songs = Song.all
    @songs = search_records(@songs, %w[title]) # Add fields you want searchable
    @songs = sort_records(@songs, 'title')     # Default sort column
    @songs = @songs.page(params[:page]).per(10) # Kaminari pagination (10 per page)
  end

  def show
    @song = Song.find(params[:id])
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

  def edit
    @song = Song.find(params[:id])
    @artists = Artist.all
    @genres = Genre.all
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to song_path(@song), notice: "Song was successfully updated."
    else
      @artists = Artist.all
      @genres = Genre.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path, notice: "Song was successfully deleted."
  end

  private

  def song_params
    params.require(:song).permit(:title, artist_ids: [], genre_ids: [])
  end
end
