class Api::V1::OffersController < ApplicationController

    def index
      @offers = paginate Offer.all.order(start_at: :desc)
      if @offers.any?
        render json: {
          data: @offers.map{ |offer|
            {
              id: offer.id,
              title: offer.title,
              description: offer.description,
              state: offer.state,
              start_at: offer.start_at,
              end_at: offer.end_at,
              image: offer.image.url
            }
          }
        }, status: :ok
      end
    end
  
    def show
      begin
        @offer = Offer.find(params[:id])
      rescue
        render json:{
          error: JSON.parse("No offer found with id: #{params[:id]}".to_json)
        }, status: :not_found
        
      else
        render json: {
          data:{
            title: @offer.title,
            description: @offer.description,
            start_at: @offer.start_at,
            end_at: @offer.end_at,
            state: @offer.state,
            image: @offer.image.url
          }
        }, status: :ok
      end
    end
  
    def offers_carosel
      offers = Offer.select(:id, :title, :image).order(created_at: :desc).where(state: 1).limit(4)
      render json:{
        data: offers.map{ |offer|
          {
            id: offer.id,
            title: offer.title,
            image: offer.image.url
            
          }
        }
      }, status: :ok
    end
  end
  