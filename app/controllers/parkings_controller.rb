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
    response = make_api_request(:get, true, "parkings/#{parking_params[:id]}")
    @parking = JSON.parse(response.body, symbolize_names: true)
  end

  # GET /parkings/new
  def new
    @parking = {}
  end

  # GET /parkings/1/edit
  def edit
    response = make_api_request(:get, true, "parkings/#{parking_params[:id]}")
    @parking = JSON.parse(response.body, symbolize_names: true)
  end

  # POST /parkings
  def create
    body = { 'parking' => parking_params }

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
    params = parking_params
    params.delete(:id)
    body = { 'parking' => params }

    response = make_api_request(:put, true, "parkings/#{parking_params[:id]}", body)
    updated = response.code == '200'

    if updated
      redirect_to parkings_path
    else
      flash[:alert] = "Erro ao atualizar estacionamento."
    end
  end

  # DELETE /parkings/1
  def destroy
    response = make_api_request(:delete, true, "parkings/#{parking_params[:id]}")
    deleted = response.code == '200'

    if deleted
      flash[:notice] = "Estacionamento removido com sucesso."
      redirect_to parkings_path
    else
      flash[:alert] = "Erro ao deletar estacionamento."
    end
  end

  private

  def parking_params
    params.permit(:id, :name, :address, :opening_time, :closing_time, :cost_per_hour)
  end
end
