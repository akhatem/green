class Api::V1::BranchesController < ApplicationController
    def index
      cities = City.all
      render json: {
        data: cities.map{ |city|
          {
            name: city.name,
            branches: 
            Branch.where(city_id: city.id).map{ |branch|
              {
                name: branch.name,
                link: branch.link,
                address: branch.address,
                long: branch.long.to_f,
                lat: branch.lat.to_f
              }
            }
          }
        }
      }, status: :ok
    end
  
    def show
      branch = Branch.find_by(city_id: params[:city_id], id: params[:branch_id])
      if branch
      render json: {
        data: {
          name: branch.name,
          city: branch.cityName,
          link: branch.link,
          address: branch.address,
          long: branch.long.to_f,
          lat: branch.lat.to_f
        }
      }, status: :ok
      end
    end
end