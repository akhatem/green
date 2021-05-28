class Api::V1::CitiesController < ApplicationController
    def index
        cities = paginate City.all
        if cities.any?
        render json: {
          message: JSON.parse("List of cities".to_json),
          data: cities.map{ |city|
            {
              id: city.id,
              name: city.name,
            }
          }
        }, status: :ok
        else
          render json:{
            error: JSON.parse("No cities found!".to_json),
          }, status: :not_found
        end
    end
end
