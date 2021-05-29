class System::CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    
    def index
        @pagy, @categories = pagy(Category.all.order(id: :asc))
    end

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
        puts "Category: #{@category}"
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
        respond_to do |format|
            if @category.update(category_params)
              format.html { redirect_to system_categories_path, notice: "Category #{@category.name} was successfully edited." }
              format.json { render :show, status: :ok, location: @category }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
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
        def destroy
            @category.destroy
            respond_to do |format|
                format.html { redirect_to system_categories_path, notice: "Category was successfully destroyed." }
                format.json { head :no_content }
              end
        end
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.fetch(:category, {})
        # params.require(:category).permit(:name, :brand_id)
    end
end
