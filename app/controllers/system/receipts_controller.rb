class System::ReceiptsController < System::SystemApplicationController

    before_action :set_receipt, only: [:show]
    before_action :set_points_movement, only: [:show]

    def index
        @pagy, @receipts = pagy(Receipt.all.order(id: :asc))
        if params[:search]
            @search_term = params[:search]
            @receipts = @receipts.search_by(@search_term)
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
                template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb",
                  header: { right: '[page] of [topage]' }, page_offset: 0
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

    def new
        @receipt = Receipt.new
    end

    def create
        receipt = Receipt.new(receipt_params)
        respond_to do |format|
            if receipt.save
                format.html { redirect_to cashier_redeem_points_path(receipt.number), 
                    notice: "Receipt #{receipt.number} was successfully created." }
                format.json { render :redeem_points, status: :created }
            else
                @customer = Customer.find_by(decoded_barcode: receipt.customer.decoded_barcode)
                format.html { redirect_to cashier_customer_info_path(receipt.customer.decoded_barcode), 
                    alert: receipt.errors.full_messages, status: :unprocessable_entity }
                format.json { render json: receipt.errors.full_messages, status: :unprocessable_entity }
                
            end
        end
    end

    private

    def set_receipt       
        @receipt = Receipt.find(params[:id])
    end

    def set_points_movement
        @points_movement = PointsMovement.where(customer_id: @receipt.customer_id).last if @receipt.customer_id
    end

    def receipt_params
        params.require(:receipt).permit(:branch_id, :customer_id, :user_id, :number, :total_price)
    end
end
