class System::CitiesController < ApplicationController
    before_action :set_city, only: [:edit, :update, :destroy]
    
    def index
        @cities = City.paginate(page: params[:page], per_page: 10).order(id: :asc)
    end

    def show
        @city = City.find(params[:id])
    end

    def new
        # byebug
        @city = City.new
        puts "City: #{@city}"
    end

    def create
        @city = City.new(city_params)

        respond_to do |format|
            if @city.save
                format.html { redirect_to system_cities_path, notice: 'City was successfully created.' }
                format.json { render :show, status: :created, location: @city }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @city.errors, status: :unprocessable_entity }
                
            end
        end
    end

    def edit
        respond_to do |format|
            if @city.write_attribute(:name, city_params[:name])
              format.html { redirect_to system_cities_path, notice: "#{@city.name} was successfully edited." }
              format.json { render :show, status: :ok, location: @city }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @city.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            byebug
          if @city.update(name: city_params[:name])
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
    end

    def city_params
        params.fetch(:city, {})
        # params.require(:city).permit(:name)
    end
end
