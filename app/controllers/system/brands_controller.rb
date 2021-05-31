class System::BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @brands = pagy(Brand.all.order(id: :asc))
      
  end

  def show
      @brand = Brand.find(params[:id])
  end

  def new
      @brand = Brand.new
      puts "Brand: #{@brand}"
  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
        if @brand.save
            format.html { redirect_to system_brands_path, notice: "Brand #{@brand.name} was successfully created." }
            format.json { render :show, status: :created, location: @brand }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @brand.errors, status: :unprocessable_entity }
            
        end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to system_brands_path, notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      def destroy
          @brand.destroy
          respond_to do |format|
              format.html { redirect_to system_brands_path, notice: "Brand was successfully destroyed." }
              format.json { head :no_content }
            end
      end
  end

  private

  def set_brand
      @brand = Brand.find(params[:id])
  end

  def brand_params
    # params.fetch(:brands, {}).permit(:name, :image, :image_cache)
      params.require(:brand).permit(:name, :image, :image_cache)
  end
end
