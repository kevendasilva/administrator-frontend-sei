class VacanciesController < ApplicationController
  include TokenValidation
  include ApplicationHelper
  layout 'dashboard'

  # GET /vacancies
  def index
    @title = "Vagas - Dashboard Administrador"
    @vacancies = {}

    response = make_api_request(:get, true, 'parkings')
    @parkings = JSON.parse(response.body, symbolize_names: true)

    parking_id = vacancy_params[:parking_id]
    if parking_id
      @current_parking = @parkings.find { |item| item[:id] == parking_id.to_i }

      response = make_api_request(:get, true, "vacancies?parking_id=#{parking_id}")
      @vacancies = JSON.parse(response.body, symbolize_names: true)
    end
  end

  # GET /vacancies/new
  def new
    @title = "Adicionar novo vaga - Dashboard Administrador"

    @vacancy = vacancy_params
  end

  # GET /vacancies/1/edit
  def edit
    @title = "Editando vaga - Dashboard Administrador"

    params = vacancy_params

    response = make_api_request(:get, true, "vacancies?parking_id=#{params[:parking_id]}")
    @vacancies = JSON.parse(response.body, symbolize_names: true)

    @vacancy = @vacancies.find { |item| item[:id] == params[:id].to_i }
  end

  # POST /vacancies
  def create
    params = vacancy_params
    body = { 'vacancy' => params }
    parking_id = params[:parking_id]

    response = make_api_request(:post, true, "vacancies", body)
    created = response.code == '201'

    if created
      flash[:notice] = "Vaga criada com sucesso."
      redirect_to "/vacancies?parking_id=#{parking_id}"
    else
      flash[:alert] = "Erro ao cadastrar vaga."
    end
  end

  # PATCH/PUT /vacancies/1
  def update
    params = vacancy_params
    id = params[:id]
    params.delete(:id)
    body = { 'vacancy' => params }

    response = make_api_request(:put, true, "vacancies/#{id}", body)
    updated = response.code == '200'

    if updated
      flash[:notice] = "Vaga atualizada com sucesso."
      redirect_to "/vacancies?parking_id=#{params[:parking_id]}"
    else
      flash[:alert] = "Erro ao atualizar vaga."
    end
  end

  # DELETE /vacancies/1
  def destroy
    response = make_api_request(:delete, true, "vacancies/#{vacancy_params[:id]}")
    deleted = response.code == '200'

    if deleted
      flash[:notice] = "Vaga removida com sucesso."
      redirect_to "/vacancies?parking_id=#{params[:parking_id]}"
    else
      flash[:alert] = "Erro ao deletar vaga."
    end
  end

  private

  def vacancy_params
    params.permit(:id, :parking_id, :code, :kind)
  end
end
