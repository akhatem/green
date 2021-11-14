class System::OfferCaroselImagesController < System::SystemApplicationController

  before_action :set_offer_carosel_image, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @offer_carosel_images = pagy(policy_scope(OfferCaroselImage.all.order(id: :asc)))
    authorize @offer_carosel_images
  end

  def show
  end

  def new
    @offer_carosel_image = OfferCaroselImage.new
    authorize @offer_carosel_image
  end

  def create
    @offer_carosel_image = OfferCaroselImage.new(offer_carosel_image_params)
    authorize @offer_carosel_image
    
    if @offer_carosel_image.save
        redirect_to system_offer_carosel_images_path
        flash[:notice] =  "Offer Carosel Image was created successfully.";
    else
      flash[:alert] = @offer_carosel_image.errors
      render :new
        
    end
  end
  
  def edit
  end

  def update
    if @offer_carosel_image.update(offer_carosel_image_params)
      redirect_to system_offer_carosel_images_path
      flash[:notice] = "Offer Carosel Image was updated successfully.";
    else
      flash[:alert] = @offer_carosel_image.errors
      render :edit
    end
  end

  def destroy
    if @offer_carosel_image.destroy
      redirect_to system_offer_carosel_images_path
      flash[:notice] =  "Offer Carosel Image was destroyed successfully."
    end
  end

  private

  def set_offer_carosel_image
    @offer_carosel_image = OfferCaroselImage.find(params[:id])
    authorize @offer_carosel_image
  end
  
  def offer_carosel_image_params
    params.require(:offer_carosel_image).permit(:image)
  end
end
