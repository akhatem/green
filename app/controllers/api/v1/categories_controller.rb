class Api::V1::CategoriesController < ApplicationController
    def index
      categories = Category.all.where(brand_id: params[:brand_id])
      brand_name = Brand.find(params[:brand_id]).name
      if categories.any?
        render json: {
          message: "List of categories in brand: #{brand_name}",
          data: categories.map{ |category|
            {
              id: category.id,
              name: category.name
            }
          }
        }, status: :ok
      else
        render json: {
          message: "Error!",
          error: JSON.parse("No Category found in brand #{brand_name}!".to_json)
        }, status: :not_found
      end
    end
  end
  