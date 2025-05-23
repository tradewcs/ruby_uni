class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    if params[:q].present?
      query = "%#{params[:q].downcase}%"
      @songs = Song.joins(:artists)
        .where("LOWER(songs.title) LIKE ? OR LOWER(artists.name) LIKE ?", query, query)
        .distinct
    else
      @songs = Song.all
    end
  end

  def show
    authorize @song
  end

  def new
    @song = Song.new
    authorize @song
  end

  def create
    @song = Song.new(song_params)
    authorize @song
    if @song.save
      redirect_to @song, notice: 'Song was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @song
  end

  def update
    authorize @song
    if @song.update(song_params)
      redirect_to @song, notice: 'Song was successfully updated.'
    else
      render :edit
    end
  end

  def destroy?
    user&.admin
  end
  
  def destroy
    authorize @song
    @song.destroy
    redirect_to songs_url, notice: 'Song was successfully destroyed.'
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist_id, :genre_id)
  end
end