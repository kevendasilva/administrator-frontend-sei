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
    @parking = {}
  end

  # GET /parkings/1/edit
  def edit
  end

  # POST /parkings
  def create
    body = {
      'parking' => {
        'name' => params[:name],
        'address' => params[:address],
        'opening_time' => params[:opening_time],
        'closing_time' => params[:closing_time],
        'cost_per_hour' => params[:cost_per_hour]
      }
    }

    response = make_api_request(:post, true, "parkings", body)
    created = response.code == '201'

    if created
      redirect_to parkings_path
    else
      flash[:alert] = "Erro ao cadastrar estacionamento."
    end
  end

  # PATCH/PUT /parkings/1
  def update
  end

  # DELETE /parkings/1
  def destroy
  end
end
