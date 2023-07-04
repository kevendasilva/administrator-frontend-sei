class ParkingsController < ApplicationController
  before_action :set_parking, only: %i[ show edit update destroy ]
  include TokenValidation
  include ApplicationHelper
  layout 'dashboard'

  # GET /parkings
  def index
    response = make_api_request(:get, true, 'parkings')
    @parkings = JSON.parse(response.body, symbolize_names: true)
  end

  # GET /parkings/1
  def show
  end

  # GET /parkings/new
  def new
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings
  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking, notice: "Parking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parkings/1
  def update
    if @parking.update(parking_params)
      redirect_to @parking, notice: "Parking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /parkings/1
  def destroy
    @parking.destroy
    redirect_to parkings_url, notice: "Parking was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking
      @parking = Parking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parking_params
      params.fetch(:parking, {})
    end
end
