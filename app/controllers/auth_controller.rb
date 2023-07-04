class AuthController < ApplicationController
  include ApplicationHelper

  def index
    response = make_api_request(:get, true, 'current_administrator')    
    valid = response.code == '200'

    if valid
      redirect_to root_path
    else
      render :index
    end
  end

  def create
    email = params[:email]
    password = params[:password]

    body = { 'administrator' => { 'email' => email, 'password' => password } }

    response = make_api_request(:post, false, 'login', body)
    success = response.code == '200'

    puts response.body

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
