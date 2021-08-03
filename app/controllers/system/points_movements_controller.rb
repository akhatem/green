class System::PointsMovementsController < System::SystemApplicationController
  def index
    @pagy, @points_movements = pagy(PointsMovement.all.order(id: :asc))
    if params[:search]
      @search_term = params[:search]
      @points_movements = @points_movements.search_by(@search_term)
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
  end

  def new
    @points_movement = PointsMovement.new
  end

  def create
    puts "===========> In points movements controller: create"
    puts "===========> params: #{params}"
    @customer = Customer.find(params[:points_movement][:customer_id])
    last_pm_total = PointsMovement.where(customer_id: @customer.id).last.total
    puts "===========> last_pm_total: #{last_pm_total}"
    respond_to do |format|
      puts "==========> params[:commit]: #{params[:commit]}"
      if params[:commit].eql?("Redeem")
        points_movement = PointsMovement.new(customer_id: @customer.id, branch_id: current_system_user.branch_id, 
          redeemed: last_pm_total, date_time: DateTime.now, total: 0, user_id: current_system_user.id)
        if points_movement.valid?
          points_movement.save
          format.html {redirect_to cashier_barcode_search_path, notice: "Points redeemed successfully." }
          format.json { render :barcode_search, status: 202 }
        else
          format.html { redirect_to cashier_customer_info_path(@customer.decoded_barcode), alert: "Points can't be redeemed!" }
          format.json { render json: points_movement.errors, status: :not_acceptable }  
        end
      else
        format.html { redirect_to cashier_barcode_search_path, notice: "No action was taken." }
        format.json { render :barcode_search, status: 200 }
      end
    end
  end

  # private 

  # def points_movement_params
  #   params.require(:points_movement).permit(:branch_id, :customer_id, :user_id, :number, :total, :date_time, :earned, :redeemed)
  # end

end