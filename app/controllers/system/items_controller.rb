class System::ItemsController < System::SystemApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_item_size, only: [:show, :edit, :update]


  def index  
    @pagy, @items = pagy(policy_scope(Item.all.order(id: :asc)))
    authorize @items
    
    if params[:search]
      @search_term = params[:search]
      @items = @items.search_by(@search_term)
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
      @item = Item.new
      authorize @item
      1.times { @item.item_sizes.build }
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    if @item.save
        redirect_to system_item_path(@item)
        flash[:notice] = "Item #{@item.name} was successfully created."
    else
      flash.now[:alert] = @item.errors.full_messages
      render :new
        
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to system_item_path(@item)
      flash[:notice] = "Item was successfully updated."
    else
      flash.now[:alert] = @item.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to system_items_path
      flash[:notice] = "Item was successfully destroyed."
    end
  
  end


  private

  def set_item
      @item = Item.find(params[:id])
      authorize @item
  end

  def set_item_size
    @item_size = ItemSize.find_by(item_id: @item.id)
end

  def item_params
      params.require(:item).permit(:name, :image, :category_id, :brand_id, 
        :description, item_sizes_attributes: [:id, :size_id, :price, :_destroy])
  end
end
