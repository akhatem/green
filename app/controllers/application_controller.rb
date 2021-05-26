class ApplicationController < ActionController::Base
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
end  