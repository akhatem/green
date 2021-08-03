class System::SystemApplicationController < ApplicationController
    
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    before_action :authenticate_system_user!
    before_action :set_customer, only: [:barcode_search, :customer_info]


    def pundit_user
        current_system_user
    end

    private 

    def set_customer
        @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    end
  
    def user_not_authorized
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || system_root_path)
    end
end