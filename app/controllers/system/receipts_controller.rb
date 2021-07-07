class System::ReceiptsController < System::SystemApplicationController

    before_action :set_receipt, only: [:show]

    def index
        @pagy, @receipts = pagy(Receipt.all.order(id: :asc))
        if params[:search]
            @search_term = params[:search]
            @receipts = @receipts.search_by(@search_term)
        end
    end

    def show
        @receipt
    end

    def new
        @receipt = Receipt.new
    end

    def create
        @receipt = Receipt.new(receipt_params)
        puts "=============> receipt.save? : #{@receipt.save}"
        respond_to do |format|
            if @receipt.save
                format.html { redirect_to system_redeem_points_path(@receipt.number), notice: "Receipt #{@receipt.number} was successfully created." }
                format.json { render :show, status: :created, location: @item }
            else
                customer = Customer.find(@receipt.customer_id)
                format.html { redirect_to system_customer_info_path(customer.decoded_barcode), status: :unprocessable_entity }
                format.json { render json: @receipt.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def set_receipt
        puts "========> In receipts controller :  params[:id]: #{params[:id]}"        
        @receipt = Receipt.find(params[:id])
    end

    def receipt_params
        puts "========> In receipts controller :  params: #{params.inspect}"
        # params.permit!#(:customer_id, :user_id, :number, :total_price)
        params.require(:receipt).permit(:branch_id, :customer_id, :user_id, :number, :total_price)
    end
end
