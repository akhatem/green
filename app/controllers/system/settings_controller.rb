class System::SettingsController < System::SystemApplicationController

  before_action :set_setting, only: [:show, :edit, :update]
    def index
       @pagy, @settings = pagy(Setting.all.order(updated_at: :desc))
    end

    def show
      @setting
    end

    def edit 
    end

    def update
      respond_to do |format|
        if @setting.update(setting_params)
          format.html { redirect_to system_settings_path, notice: "#{@setting.name} was successfully updated." }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @setting.errors, status: :unprocessable_entity }
        end
      end
    end

    private 
    
    def setting_params
        params.require(:setting).permit(:name, :description)
    end

    def set_setting
      @setting = Setting.find(params[:id])
    end
end