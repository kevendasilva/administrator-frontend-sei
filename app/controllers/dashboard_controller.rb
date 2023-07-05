class DashboardController < ApplicationController
  include TokenValidation
  include ApplicationHelper

  def index
    @title = "Página inicial - Dashboard Administrador"
  end
end
