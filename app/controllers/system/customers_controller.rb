class System::CustomersController < System::SystemApplicationController

  before_action :set_customer, only: [:show]
  
  def index
    @pagy, @customers = pagy(Customer.all.order(id: :asc))
    if params[:search]
      @search_term = params[:search]
      @customers = @customers.search_by(@search_term)
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
          template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb"
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
          template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_show_pdf.html.erb",
            header: { right: '[page] of [topage]' }, page_offset: 0
      end
    end
  end

  private
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
