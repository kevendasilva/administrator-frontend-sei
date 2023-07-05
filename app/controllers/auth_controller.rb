class AuthController < ApplicationController
  include ApplicationHelper

  def index
    @title = "Página de login - Dashboard Administrador"

    response = make_api_request(:get, true, 'current_administrator')    
    valid = response.code == '200'

    if valid
      redirect_to root_path
    else
      render :index
    end
  end

  def create
    params = new_login_params
    params.delete(:authenticity_token)

    body = { 'administrator' => params }

    response = make_api_request(:post, false, 'login', body)
    success = response.code == '200'

    if success
      cookies[:auth_token] = response.header['Authorization']

      flash[:notice] = 'Login successful'
      redirect_to root_path
    else
      message = response.body

      flash[:alert] = "Login failed: #{message}"
      redirect_to root_path
    end
  end

  def destroy
    response = make_api_request(:delete, true, 'logout')
    success = response.code == '200'

    if success
      redirect_to "/login"
    end
  end

  private

  def new_login_params
    params.permit(:authenticity_token, :email, :password)
  end
end
