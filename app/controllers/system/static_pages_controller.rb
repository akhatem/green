class System::StaticPagesController < System::SystemApplicationController

  before_action :set_customer, only: [:barcode_search, :customer_info]
  before_action :set_receipt, only: [:redeem_points]
  def index
    render :index
  end

  def barcode_search
    respond_to do |format|
      if @customer
        format.html {redirect_to system_customer_info_path(@customer.decoded_barcode), notice: "Customer #{@customer.name} found." }
        format.json { render :customer_info, status: :ok }
      else
        format.html { render :barcode_search, alert: "Customer not found!", status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def customer_info
    @customer
  end

  def redeem_points
    @receipt
  end

  private

  def set_customer
    @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
  end

  def set_receipt
    puts "=========> In static_pages : params: #{params}"
    # @receipt = Receipt.find_by(number: params[:receipts][:number])
  end

  def receipt_params
    params.require(:receipt).permit(:customer_id, :user_id, :number, :total_price)
  end
end
