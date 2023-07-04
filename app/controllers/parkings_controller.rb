class ParkingsController < ApplicationController
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
    response = make_api_request(:get, true, "parkings/#{params[:id]}")
    @parking = JSON.parse(response.body, symbolize_names: true)
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
end
