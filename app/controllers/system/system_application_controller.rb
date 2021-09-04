class System::SystemApplicationController < ApplicationController
    
    after_action :verify_authorized, except: [:index, :barcode_search, :customer_info, :redeem_points]
    after_action :verify_policy_scoped, only: :index
    
    before_action :authenticate_user!
    # before_action :set_customer, only: [:barcode_search, :customer_info]

    def pundit_user
        current_user
    end

    private 

    # def set_customer
    #     @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    # end
    
end