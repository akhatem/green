class System::OfferCaroselImagesController < ApplicationController

  before_action :set_offer_carosel_image, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @offer_carosel_images = pagy(OfferCaroselImage.all.order(id: :asc))
  end

  def show
    @offer_carosel_image = OfferCaroselImage.find(params[:id])
  end

  def new
    @offer_carosel_image = OfferCaroselImage.new
  end
  
  def edit
  end

  def create
    offer_carosel_image = OfferCaroselImage.new(offer_carosel_image_params)

    respond_to do |format|
        if offer_carosel_image.save
            format.html { redirect_to system_offer_carosel_images_path, notice: "Offer Carosel Image was created successfully." }
            format.json { render :index, status: :created, location: offer_carosel_image }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: offer_carosel_image.errors, status: :unprocessable_entity }
            
        end
    end
  end

  def update
    respond_to do |format|
      if @offer_carosel_image.update(offer_carosel_image_params)
        format.html { redirect_to system_offer_carosel_images_path, notice: "Offer Carosel Image was updated successfully." }
        format.json { render :index, status: :ok, location: @offer_carosel_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offer_carosel_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @offer_carosel_image.destroy
        format.html { redirect_to system_offer_carosel_images_path, notice: "Offer Carosel Image was destroyed successfully." }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_offer_carosel_image
    @offer_carosel_image = OfferCaroselImage.find(params[:id])
  end
  
  def offer_carosel_image_params
    params.require(:offer_carosel_image).permit(:image)
  end
end
