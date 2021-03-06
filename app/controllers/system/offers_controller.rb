class System::OffersController < System::SystemApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  
  def index
      @pagy, @offers = pagy(policy_scope(Offer.all.order(id: :asc)))
      if params[:search]
        @search_term = params[:search]
        @offers = @offers.search_by(@search_term)
    end
  end

  def show
  end

  def edit    
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to system_offer_path(@offer), notice: "Offer was successfully updated." }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end    
  end

  def new
    @offer = Offer.new
    authorize @offer
  end

  def create   
    @offer = Offer.new(offer_params)
    authorize @offer
    if @offer.save
        redirect_to system_offer_path(@offer)
        flash[:notice] = "Offer was successfully created."
    else
        flash[:alert] = @offer.errors.full_messages
        
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to system_offers_path, notice: "offer was destroyed successfully." }
      format.json { head :no_content }
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end

  def offer_params
      params.require(:offer).permit(:title, :description, :start_at, :end_at, :image, :state)
  end
end
