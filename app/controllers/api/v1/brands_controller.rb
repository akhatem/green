require 'json'
class Api::V1::BrandsController < ApplicationController
  
  def index
    begin
      @brands = Brand.all
    rescue
      render json: {
        message: JSON.parse("No brands found!".to_json)
      }, status: :not_found
    else
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
    end
  end
end
