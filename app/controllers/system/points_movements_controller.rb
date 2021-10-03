class System::PointsMovementsController < System::SystemApplicationController

  skip_after_action :verify_authorized
  before_action :set_points_movement, only: [:show]

  def index
    @pagy, @points_movements = pagy(policy_scope(PointsMovement.all.order(id: :asc)))
    if params[:search]
      @search_term = params[:search]
      @points_movements = @points_movements.search_by(@search_term)
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
    @points_movement = PointsMovement.new
  end

  def create
    customer = Customer.find(params[:points_movement][:customer_id])
    last_pm_total = PointsMovement.where(customer_id: customer.id).last.total
    puts "=================================================="
    puts "last pm total: #{last_pm_total}"
    puts "=================================================="
    respond_to do |format|
      if params[:commit].eql?("Redeem")
        points_movement = PointsMovement.new(customer_id: customer.id, branch_id: current_user.branch_id, 
          redeemed: last_pm_total, date_time: Time.current, total: 0, user_id: current_user.id, receipt_id: Receipt.last.id)
        if points_movement.valid?
          points_movement.save
          format.html {redirect_to cashier_barcode_search_path, notice: "Points redeemed successfully." }
          format.json { render :barcode_search, status: 202 }
        else
          format.html { redirect_to cashier_customer_info_path(customer.decoded_barcode), alert: "Points can't be redeemed!" }
          format.json { render json: points_movement.errors.full_messages, status: :not_acceptable }  
        end
      else
        format.html { redirect_to cashier_barcode_search_path, notice: "No action was taken." }
        format.json { render :barcode_search, status: 200 }
      end
    end
  end

  def daily_points_movements
    # byebug
    @pagy, @branches = pagy(Branch.all)
    # @pagy, @daily_points_movements = pagy_array(policy_scope(PointsMovement.group(:branch_id, "DATE(date_time)"))
    #   .order("DATE(date_time) ASC")
    #   .pluck(:branch_id, "DATE(date_time)", "SUM(earned)", "SUM(redeemed)", "SUM(total)"))
    
    daily_points_movements = []
    if params[:search]
      @search_term = params[:search]
      
      @daily_points_movements.each do |dpm|
        if dpm[1].strftime("%A, %d %B %Y").include?(@search_term.capitalize)
          daily_points_movements.push(dpm)
        end
      end
      @daily_points_movements = daily_points_movements
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{params[:action]}_#{DateTime.now.strftime('%d/%m/%Y')}", 
          template: "system/#{params[:controller].split('/').second}/#{params[:action]}_index_pdf.html.erb",
          header: { right: "#{@pagy.page} of #{@pagy.last}" }
      end
    end
  end

  private

  def set_points_movement
    @points_movement = PointsMovement.find(params[:id])
  end
end