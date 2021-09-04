class System::NotificationsController < System::SystemApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @notifications = pagy(policy_scope(Notification.all.order(id: :asc)))
    authorize @notifications
    if params[:search]
      @search_term = params[:search]
      @notifications = @notifications.search_by(@search_term)
    end
  end

  def show
  end

  def edit    
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to system_notification_path(@notification), notice: "Notification was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end    
  end

  def new
    @notification = Notification.new
    authorize @notification
  end

  def create   
    @notification = Notification.new(notification_params)
    authorize @notification
    respond_to do |format|
      if @notification.save
          format.html { redirect_to system_notification_path(@notification), notice: "Notification was successfully created." }
          format.json { render :show, status: :created, location: @notification }
      else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @notification.errors, status: :unprocessable_entity }
          
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to system_notifications_path, notice: "notification was destroyed successfully." }
      format.json { head :no_content }
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
    authorize @notification
  end

  def notification_params
      params.require(:notification).permit(:title, :description, :create_date, :image)
  end
end
