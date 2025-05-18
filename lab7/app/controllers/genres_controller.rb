class GenresController < ApplicationController
  def index
    if params[:q].present?
      query = "%#{params[:q].downcase}%"
      @genres = Genre.where("LOWER(name) LIKE ?", query)
    else
      @genres = Genre.all
    end
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: "Genre was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end