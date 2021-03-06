class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    def require_login
        authenticate_token || render_unauthorized("access denied")
    end
      
    def current_user
        @current_user ||= authenticate_token
    end

    def authenticate_token
        #authenticate_with_http_token comes from rails
        authenticate_with_http_token do |token, options|
          User.find_by(auth_token: token)
        end
    end
      
    protected
    def render_unauthorized(message)
        errors = { errors: [ { detail: message } ] }
        render json: errors, status: :unauthorized
    end
      
    

end
