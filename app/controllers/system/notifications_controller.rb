class System::NotificationsController < System::SystemApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  
  def index
      @pagy, @notifications = pagy(Notification.all.order(created_at: :desc))
  end

  def show
      @notification
  end

  def edit    
  end

  def update
      # byebug
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to system_notification_path(@notification), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end    
  end

  def new
    @notification = Notification.new
  end

  def create   
    @notification = Notification.new(notification_params)

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

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
      params.require(:notification).permit(:title, :description, :create_date)
  end
end
