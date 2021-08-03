class ApplicationController < ActionController::Base
    include Pagy::Backend
    include Rails::Pagination
    
    protect_from_forgery prepend: true, with: :null_session


    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end

    def process_header_token
        # header: { 'Authorization': 'Bearer <token>' }
        auth_header.split(' ')[1] if auth_header
    end

    def header_token
        begin
            process_header_token
        rescue JWT::InvalidSubError
            nil
        end
    end

    def logged_in_user
        begin
            header_token
            Customer.find_by(token: header_token)
        rescue
            nil
        end
    end

    def logged_in?
        !!logged_in_user
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

    def generate_verification_code 
        charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
        code = Array.new(4) { charset.sample }.uniq.join
        if code.length < 4
            generate_verification_code
        else
            return code
        end
    end
end  