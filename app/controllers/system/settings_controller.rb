class System::SettingsController < System::SystemApplicationController
    def index
       @pagy, @settings = pagy(Setting.all.order(updated_at: :desc))
    end

    def show
      @setting = Setting.find(params[:id])
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
end