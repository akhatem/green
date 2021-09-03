class System::ItemsController < System::SystemApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_item_size, only: [:show, :edit, :update]
  
  def index
    @pagy, @items = pagy(Item.all.order(id: :asc))

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
            header: { right: '[page] of [topage]' }, page_offset: 0
      end
    end
  end

  def show
      @item = Item.find(params[:id])
  end

  def new
      @item = Item.new
      1.times { @item.item_sizes.build }
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
        if @item.save
            format.html { redirect_to system_item_path(@item), notice: "Item #{@item.name} was successfully created." }
            format.json { render :show, status: :created, location: @item }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @item.errors, status: :unprocessable_entity }
            
        end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to system_item_path(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to system_items_path, notice: "Item was successfully destroyed." }
        format.json { head :no_content }
      end
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
