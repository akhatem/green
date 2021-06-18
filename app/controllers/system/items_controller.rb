class System::ItemsController < System::SystemApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @pagy, @items = pagy(Item.all.order(id: :asc))
      
  end

  def show
      @item = Item.find(params[:id])
  end

  def new
      @item = Item.new
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
  end

  def item_params
      params.require(:item).permit(:name, :image, :category_id, :brand_id, :description)
  end
end
