class System::SizesController < System::SystemApplicationController
    before_action :set_size, only: [:edit, :update, :destroy]
    
    def index
      @pagy, @sizes = pagy(policy_scope(Size.all.order(id: :asc)))
      authorize @sizes
      if params[:search]
        @search_term = params[:search]
        @sizes = @sizes.search_by(@search_term)
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

    def new
        @size = Size.new
        authorize @size
    end
  
    def create
      @size = Size.new(size_params)
      authorize @size
      respond_to do |format|
          if @size.save
              format.html { redirect_to system_sizes_path, notice: "Size #{@size.name} was successfully created." }
              format.json { render :index, status: :created }
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
          format.html { redirect_to system_sizes_path, notice: "Size was successfully updated." }
          format.json { render :index, status: :ok }
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
        authorize @size
    end
  
    def size_params
        params.require(:size).permit(:name)
    end
end
