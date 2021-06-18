class System::ItemSizesController < System::SystemApplicationController
    before_action :set_item_size, only: [:show, :edit, :update, :destroy]
    
    def index
      @pagy, @item_sizes = pagy(ItemSize.all.order(id: :asc))
    end

    def show
      @item_size = ItemSize.find(params[:id])
    end

    def new
      @item_size = ItemSize.new   
    end

    def create
      @item_size = ItemSize.new(item_size_params)

      respond_to do |format|
        if @item_size.save
            format.html { redirect_to system_item_sizes_path, notice: "Item Size was successfully created." }
            format.json { render :show, status: :created, location: @item_size }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @item_size.errors, status: :unprocessable_entity }
            
        end
      end
    end

    def edit
    end
  
    def update
    # byebug
      respond_to do |format|
        if @item_size.update(item_size_params)
          format.html { redirect_to system_item_sizes_path, notice: "Item was successfully updated." }
          format.json { render :show, status: :ok, location: @item_size }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @item_size.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
        @item_size.destroy
        respond_to do |format|
            format.html { redirect_to system_items_path, notice: "Item was successfully destroyed." }
            format.json { head :no_content }
          end
    end

  private

  def set_item_size
    @item_size = ItemSize.find(params[:id])
  end

  def item_size_params
      params.require(:item_size).permit(:size_id, :item_id)
  end
end
