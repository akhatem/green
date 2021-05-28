class System::CustomersController < ApplicationController
  
  def index
    @customers = Customer.paginate(page: params[:page], per_page: 10).order(id: :asc)
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
