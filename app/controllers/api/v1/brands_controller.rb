class Api::V1::BrandsController < ApplicationController
  
  def index
    @brands = Brand.all
    if @brands.any?
    render json: {
      message: "List of brand(s)",
      data: @brands.map{ |brand|
        {
          id: brand.id,
          name: brand.name,
          image: brand.image.url
        }
      }
    }, status: :ok
    else
      render json: {
        message: "Error!",
        error: JSON.parse("No Category found in brand #{brand.name}!".to_json)
      }, status: :not_found
    end
  end
end
