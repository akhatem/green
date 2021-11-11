class System::ReceiptsController < System::SystemApplicationController
    skip_after_action :verify_authorized
    before_action :set_receipt, only: [:show]
    before_action :set_points_movement, only: [:show]

    def index
        @pagy, @receipts = pagy(policy_scope(Receipt.all.order(id: :asc)))
        authorize @receipts
        
        if params[:search]
            @search_term = params[:search]
            @receipts = @receipts.search_by(@search_term)
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
                template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb",
                header: { right: "#{@pagy.page} of #{@pagy.last}" }
            end
        end
    end

    def show
        # authorize @receipt
        
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
        @receipt = Receipt.new(create_params)
        
        if @receipt.save
            redirect_to cashier_redeem_points_path(@receipt.number)
            flash[:notice] = "Receipt # #{@receipt.number} saved successfully."
        else
            @customer = Customer.find_by(decoded_barcode: @receipt.customer.decoded_barcode)
            redirect_to cashier_customer_info_path(@receipt.customer.decoded_barcode)
            flash[:alert] = ["Receipt number already exists!"]
        end
    end

    private

    def set_receipt       
        @receipt = Receipt.find(params[:id])
        authorize @receipt
    end

    def set_points_movement
        @points_movement = PointsMovement.where(earned: 0).find_by(receipt_id: @receipt.id)
    end

    def create_params
        params.require(:receipt).permit(:customer_id, :branch_id, :user_id, :number, :total_price)
    end
end
