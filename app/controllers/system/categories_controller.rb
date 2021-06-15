class System::CategoriesController < System::SystemApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    
    def index
        @pagy, @categories = pagy(Category.all.order(updated_at: :desc))
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    def create
    # byebug
        @category = Category.new(category_params)

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
    end

    def category_params
        params.require(:category).permit(:name, :brand_id)
    end
end
