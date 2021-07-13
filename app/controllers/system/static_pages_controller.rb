class System::StaticPagesController < System::SystemApplicationController

  before_action :set_receipt, only: [:redeem_points]
  before_action :set_customer, except: [:index, :barcode_search]
  def index
    render :index
  end

  def barcode_search
    @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    if params[:decoded_barcode]
      respond_to do |format|
        if @customer
          format.html {redirect_to system_customer_info_path(@customer.decoded_barcode), notice: "Customer #{@customer.name} found." }
          format.json { render :customer_info, status: :ok }
        else
          format.html { render :barcode_search, alert: "Customer not found!", status: :not_found }
          format.json { render json: @customer.errors, status: :not_found }
        end
      end
    else
      render :barcode_search
    end
  end
  
  def customer_info
    # puts "=============> receipt.save? : #{@receipt.save}"
    respond_to do |format|
      if @receipt.save
          format.html { redirect_to system_redeem_points_path(@receipt.number), 
            notice: "Receipt #{@receipt.number} was successfully created." }
          format.json { render :redeem_points, status: :created, location: @item }
      else
          puts "=============> receipt.errors? : #{@receipt.errors.full_messages}"
          # @customer = Customer.find_by(decoded_barcode: @receipt.customer.decoded_barcode)
          format.html { redirect_to system_customer_info_path(@receipt.customer.decoded_barcode), 
            alert: "Something went wrong!", status: :unprocessable_entity }
          format.json { render json: @receipt.errors, status: :unprocessable_entity }
          
      end
    end
  end

  def redeem_points
    @receipt
    @customer
    @points_movement = PointsMovement.find_by(customer_id: @customer.id)
    points_movement = PointsMovement.new(customer_id: @customer.id, branch_id: current_system_user.branch_id, 
      redeemed: @points_movement.total, earned: 0, date_time: DateTime.now, total: 0, user_id: current_system_user.id) 
      if points_movement.save
        points_movement.save
        redirect_to system_barcode_search_path, notice: "Points redeemed successfully."
      else
        render :redeem_points, alert: "Something went wrong!", status: :not_acceptable
      end    
  end

  private

  def set_receipt
    puts "=========> In static_pages : params: #{params}"
    @receipt = Receipt.find_by(number: params[:receipt_number])
  end
  
  def set_customer
    if params[:decoded_barcode]
      @customer = Customer.find_by(decoded_barcode: params[:decoded_barcode])
    else
      @customer = Customer.find(@receipt.customer_id)
    end
  end

  def receipt_params
    params.require(:receipt).permit(:customer_id, :user_id, :number, :total_price)
  end
end
