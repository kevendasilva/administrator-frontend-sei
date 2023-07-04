module TokenValidation
    extend ActiveSupport::Concern
    include ApplicationHelper
  
    included do
      before_action :validate_token
    end
  
    private
  
    def validate_token
      response = make_api_request(:get, true, 'current_administrator')

      valid = response.code == '200'
      message = response.body

      if not valid
        flash[:alert] = "Token inválido: #{message}"
        redirect_to '/login'
      end
    end
  end
  