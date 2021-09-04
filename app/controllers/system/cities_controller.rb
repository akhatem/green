class System::CitiesController < System::SystemApplicationController
    before_action :set_city, only: [:show, :edit, :update, :destroy]
    
    def index
        @pagy, @cities = pagy(policy_scope(City.all.order(id: :asc)))
        authorize @cities
        if params[:search]
            @search_term = params[:search]
            @cities = @cities.search_by(@search_term)
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
    end

    def new
        @city = City.new
        authorize @city
    end
  
    def create
      @city = City.new(city_params)
      authorize @city
      respond_to do |format|
          if @city.save
              format.html { redirect_to system_cities_path, notice: "City #{@city.name} was successfully created." }
              format.json { render :index, status: :created }
          else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @city.errors, status: :unprocessable_entity }
              
          end
      end
    end

    def edit
    end

    def update
        respond_to do |format|
          if @city.update(city_params)
            format.html { redirect_to system_cities_path, notice: "City was successfully updated." }
            format.json { render :show, status: :ok, location: @city }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @city.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        def destroy
            @city.destroy
            respond_to do |format|
                format.html { redirect_to system_cities_path, notice: "City was successfully destroyed." }
                format.json { head :no_content }
              end
        end
    end

    private

    def set_city
        @city = City.find(params[:id])
        authorize @city
    end

    def city_params
        params.require(:city).permit(:name)
    end
end
