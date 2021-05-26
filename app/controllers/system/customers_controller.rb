class System::CustomersController < ApplicationController
  
  def index
    Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
