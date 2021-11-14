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
          template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_show_pdf.html.erb"
          # ,header: { right: '[page] of [topage]' }, page_offset: 0
      end
    end
  end

  def new
    @points_movement = PointsMovement.new
  end

  def create
    customer = Customer.find(params[:points_movement][:customer_id])
    last_pm_total = PointsMovement.where(customer_id: customer.id).last.total
    points_movement = PointsMovement.new(customer_id: customer.id, branch_id: current_user.branch_id, 
      redeemed: last_pm_total, date_time: Time.current, total: 0, user_id: current_user.id, receipt_id: Receipt.last.id)
    if points_movement.save
      redirect_to cashier_barcode_search_path
      flash[:notice] =  ["Points redeemed successfully."]
    else
      redirect_to cashier_customer_info_path(customer.decoded_barcode)
      flash[:alert] = ["Points can't be redeemed!"]
    end
  end

  def daily_points_movements
    @pagy, @branches = pagy(Branch.all, per_page: 8)
    # daily_points_movements = []
    # @branches.each do |branch|
    #   daily_points_movements |= PointsMovement.where(branch_id: branch.id)
    #   .group(branch.id)
    #   .group("DATE(date_time)")
    #   .order("DATE(date_time) ASC")
    #   .pluck(branch.id, "DATE(date_time)", "SUM(earned)" , "SUM(redeemed)" , "SUM(total)")
    # end

    # @pagy_a, @daily_points_movements = pagy_array(daily_points_movements)


    daily_points_movements = []
    @branches.each do |branch|
      daily_points_movements |= PointsMovement.where(branch_id: branch.id)
        .select(:branch_id)
        .group(branch.id)
        .group("DATE(date_time)")
        .order("DATE(date_time) ASC")
        .pluck(branch.id, "DATE(date_time)", "SUM(earned)" , "SUM(redeemed)" , "SUM(total)")
    end

    @pagy_a, @daily_points_movements = pagy_array(daily_points_movements)

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