class System::SizesController < System::SystemApplicationController
    before_action :set_size, only: [:edit, :update, :destroy]
    
    def index
        @pagy, @sizes = pagy(Size.all.order(id: :asc))
    end

    def new
        @size = Size.new
        puts "Size: #{@size}"
    end
  
    def create
      @size = Size.new(size_params)
      respond_to do |format|
          if @size.save
              format.html { redirect_to system_sizes_path, notice: "Size #{@size.name} was successfully created." }
            #   format.json { render :show, status: :created, location: @size }
          else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @size.errors, status: :unprocessable_entity }
              
          end
      end
    end

    def edit
    end
  
    def update
      respond_to do |format|
        if @size.update(size_params)
          format.html { redirect_to system_items_path, notice: "Size was successfully updated." }
          format.json { render :show, status: :ok, location: @size }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @size.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
        @size.destroy
        respond_to do |format|
        format.html { redirect_to system_sizes_path, notice: "Size was successfully destroyed." }
        format.json { head :no_content }
        end
    end


    private

    def set_size
        @size = Size.find(params[:id])
    end
  
    def size_params
        params.require(:size).permit(:name, :price)
    end
end
