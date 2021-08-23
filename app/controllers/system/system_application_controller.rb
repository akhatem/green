class System::SystemApplicationController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_customer, only: [:barcode_search, :customer_info]

    def pundit_user
        current_user
    end

    private 

    def set_customer
        @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    end
end