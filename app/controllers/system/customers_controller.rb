class System::CustomersController < System::SystemApplicationController
  
  def index
    @pagy, @customers = pagy(Customer.all.order(id: :asc))
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
