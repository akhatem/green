class System::BrandsController < System::SystemApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @brands = pagy(policy_scope(Brand.all.order(id: :asc)))
    authorize @brands
  end

  def show
  end

  def new
      @brand = Brand.new
      authorize @brand
  end

  def create
    @brand = Brand.new(brand_params)
    authorize @brand
    respond_to do |format|
        if brand.save
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
      if @brand.update(brand_params)
        redirect_to system_brands_path
        flash[:notice] = "Brand was successfully updated."
      else
        flash.now[:alert] = @brand.errors.full_messages
        render :edit
      end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
        format.html { redirect_to system_brands_path, notice: "Brand was successfully destroyed." }
        format.json { head :no_content }
    end
  end


  private

  def set_brand
      @brand = Brand.find(params[:id])
      authorize @brand
  end

  def brand_params
      params.require(:brand).permit(:name, :image)
  end
end
