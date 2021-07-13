class System::CustomersController < System::SystemApplicationController
  
  def index
    @pagy, @customers = pagy(Customer.all.order(id: :asc))
    if params[:search]
      @search_term = params[:search]
      @customers = @customers.search_by(@search_term)
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
