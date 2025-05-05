class ArtistsController < ApplicationController
    before_action :set_artist, only: %i[show edit update destroy]
  
    def index
      @artists = Artist.all
    end
  
    def show
    end
  
    def new
      @artist = Artist.new
    end
  
    def create
      @artist = Artist.new(artist_params)
      if @artist.save
        redirect_to artist_path(@artist), notice: "Artist was successfully created."
      else
        flash.now[:alert] = "Error: Unable to create artist."
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @artist.update(artist_params)
        redirect_to artist_path(@artist), notice: "Artist was successfully updated."
      else
        flash.now[:alert] = "Error: Unable to update artist."
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      p "sdafsd"
      @artist = Artist.find(params[:id])
      
      if @artist.destroy
        redirect_to artists_path, notice: "Artist was successfully deleted."
      else
        redirect_to artists_path, alert: "Failed to delete the artist."
      end
    end

  
    private
  
    def set_artist
      @artist = Artist.find(params[:id])
    end
  
    def artist_params
      params.require(:artist).permit(:name)
    end
  end
  
