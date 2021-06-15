require 'json'
class Api::V1::BrandsController < ApplicationController
  
  def index
    begin
      @brands = Brand.all
    rescue
      render json: {
        message: JSON.parse("No brands found!".to_json)
        status: :not_found,
      } and return
    else
      render json: {
        message: JSON.parse("List of brand(s)".to_json),
        data: @brands.map{ |brand|
          {
            id: brand.id,
            name: brand.name,
            image: brand.image_url
          }
        }
      }, status: :ok
    end
  end
end