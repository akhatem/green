class Cashier::CashierPagesController < System::SystemApplicationController

  before_action :set_receipt, only: [:customer_info, :redeem_points]
  before_action :set_customer, except: [:barcode_search]
  before_action :set_points_movement, only: [:redeem_points]
  
  def barcode_search
    @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    if params[:decoded_barcode]
      if @customer
        redirect_to cashier_customer_info_path(@customer.decoded_barcode)
        flash[:notice] = ["Customer #{@customer.name} found."]
      else
        flash.now[:alert] = ["Customer not found!"]
        render :barcode_search
      end
    else
      render :barcode_search
    end
  end
  
  def customer_info
  end

  def redeem_points
  end

  private

  def set_receipt
    @receipt = Receipt.find_by(number: params[:receipt_number])
  end
  
  def set_customer
    if params[:decoded_barcode]
      @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    else
      @customer = Customer.find(@receipt.customer_id)
    end
  end

  def set_points_movement
    @points_movement = PointsMovement.where(customer_id: @customer.id).last
  end

  def receipt_params
    params.require(:receipt).permit(:customer_id, :user_id, :number, :total_price)
  end
end
