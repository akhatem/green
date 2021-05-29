class System::ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    
    def index
      @pagy, @items = pagy(Item.all.order(id: :asc))
        
    end
  
    def show
        @item = Item.find(params[:id])
    end
  
    def new
        @item = Item.new
        puts "Item: #{@item}"
    end
  
    def create
      @item = Item.new(item_params)
  
      respond_to do |format|
          if @item.save
              format.html { redirect_to system_items_path, notice: "Item #{@item.name} was successfully created." }
              format.json { render :show, status: :created, location: @item }
          else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @item.errors, status: :unprocessable_entity }
              
          end
      end
    end
  
    def edit
        respond_to do |format|
            if @item.update(item_params)
              format.html { redirect_to system_items_path, notice: "Item #{@item.name} was successfully edited." }
              format.json { render :show, status: :ok, location: @item }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @item.errors, status: :unprocessable_entity }
            end
        end
    end
  
    def update
      respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to system_items_path, notice: "Item was successfully updated." }
          format.json { render :show, status: :ok, location: @item }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
        def destroy
            @item.destroy
            respond_to do |format|
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
        # params.fetch(:item, {})
        params.require(:item).permit(:name, :image, :image_cache) 
    end
end
  