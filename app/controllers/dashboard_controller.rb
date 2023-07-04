class DashboardController < ApplicationController
  include TokenValidation
  include ApplicationHelper

  def index
    @response = make_api_request(:get, true, 'parkings')
  end
end
