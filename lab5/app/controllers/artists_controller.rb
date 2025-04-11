class ArtistsController < ApplicationController
    before_action :set_artist, only: %i[show edit update destroy]

    def index
        @artists = Artist.all
    end

    def new
        @artist = Artist.new
    end

    def create
        @artist = Artist.new(artist_params)
        if @artist.save
            flash[:notice] = "Artist was successfully created."
            redirect_to artists_path
        else
            flash[:alert] = "Eror: Unable to create artist."
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def edit
    end

    def update
        if @artist.update(artist_params)
            flash[:notice] = "Artist was successfully updated."
            redirect_to artists_path
        else
            render :edit
        end
    end

    def destroy
        @artist.destroy
        flash[:notice] = "Artist was successfully deleted."
        redirect_to artists_path
    end

    def set_artist
        @artist = Artist.find(params[:id])
    end

    private

    def artist_params
        params.require(:artist).permit(:name)
    end
end
