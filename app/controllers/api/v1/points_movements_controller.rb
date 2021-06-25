class Api::V1::PointsMovementsController < ApplicationController
    def index
        customer = paginate Customer.find_by(token: header_token) 
        if !header_token || customer.nil?
          render json: { 
            error: JSON.parse("Unauthorized request!".to_json),
          }, status: :unauthorized   
        else
          render json: {
            data: customer.points_movements.map{ |pm|
              {
                date: pm.date_time,
                earned: pm.earned,
                redeemed: (- pm.redeemed),
                total: pm.total
              }
            }
          }, status: :ok
        end
    end
end
