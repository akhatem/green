require 'json'
class Api::V1::BrandsController < ApplicationController
  
  def index
    begin
      @brands = Brand.all
    rescue
      respond_to do |format|
        format.json do
          render json: {
            message: JSON.parse("No brands found!".to_json)
          }.to_json, status: :not_found
          end
        end
      else
        respond_to do |format|
          format.json do
            render json: {
              message: "List of brand(s)",
              data: @brands.map{ |brand|
                {
                  id: brand.id,
                  name: brand.name,
                  image: brand.image.url
                }
              }
            }.to_json, status: :ok
          end
        end
    end
  end
end