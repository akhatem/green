class System::SystemApplicationController < ApplicationController
    include Pundit
    include Pagy::Backend
    
    before_action :authenticate_system_user!
    before_action :set_customer, only: [:barcode_search, :customer_info]

    private 

    def set_customer
        @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    end
end