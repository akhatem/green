class System::CategoriesController < System::SystemApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    
    def index
        @pagy, @categories = pagy(Category.all.order(id: :asc))
        authorize @categories
        if params[:search]
            @search_term = params[:search]
            @categories = @categories.search_by(@search_term)
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
                template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb"
            end
        end
    end

    def show
    end

    def new
        @category = Category.new
        authorize @category
    end

    def create
        @category = Category.new(category_params)
        authorize @category
        
        respond_to do |format|
            if @category.save
                format.html { redirect_to system_categories_path, notice: "Category #{@category.name} was successfully created." }
                format.json { render :show, status: :created, location: @category }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @category.errors, status: :unprocessable_entity }
                
            end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
          if @category.update(category_params)
            format.html { redirect_to system_categories_path, notice: "Category was successfully updated." }
            format.json { render :show, status: :ok, location: @category }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @category.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @category.destroy
        respond_to do |format|
            format.html { redirect_to system_categories_path, notice: "Category was successfully destroyed." }
            format.json { head :no_content }
            end
    end

    private

    def set_category
        @category = Category.find(params[:id])
        authorize @category
    end

    def category_params
        params.require(:category).permit(:name, :brand_id)
    end
end
