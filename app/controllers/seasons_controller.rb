class SeasonsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, Season
    @seasons = Season.all.reverse
  end

  def show
  end

  def new
    authorize! :create, @season
    @season = Season.new
  end

  def edit
    authorize! :update, @season
  end

  def create
    @season = Season.new(season_params)

    respond_to do |format|
      if @season.save
        format.html { redirect_to root_path, notice: 'La temporada ha sido creada correctamente.' }
        format.json { render :show, status: :created, location: @season }
      else
        format.html { render :new }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to root_path, notice: 'La temporada fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @season }
      else
        format.html { render :edit }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @season
    @season.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'La temporada fue eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_season
      @season = Season.find(params[:id])
    end

    def season_params
      params.require(:season).permit(:startdate, :enddate)
    end
end
