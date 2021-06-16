class Api::V1::OffersController < ApplicationController
    def index
      offers = paginate Offer.all.order(start_at: :desc)
      if offers.any?
        render json: {
          data: offers.map{ |offer|
            {
              id: offer.id,
              title: JSON.parse(offer.title).join(', ').tr(',', ''),
              description: JSON.parse(offer.description).join(', ').tr(',', ''),
              state: offer.state,
              start_at: offer.start_at,
              end_at: offer.end_at,
              image: offer.image_url
            }
          }
        }, status: :ok
      end
    end
  
    def show
      offer = Offer.find(params[:id])
      if offer
        render json: {
          data:{
            title: JSON.parse(offer.title).join(', ').tr(',', ''),
            description: JSON.parse(offer.description).join(', ').tr(',', ''),
            start_at: offer.start_at,
            end_at: offer.end_at,
            state: offer.state,
            image: offer.image_url
          }
        }, status: :ok
      else
        render json:{
          error: JSON.parse("No offer found with id: #{Offer.find(params[:id])}".to_json)
        }, status: :not_found
      end
    end
  
    def offers_carosel
      offers = Offer.select(:id, :title, :image).order(created_at: :desc).where(state: 1).limit(4)
      render json:{
        data: offers.map{ |offer|
          {
            id: offer.id,
            title: offer.title,
            image: offer.image_url
            
          }
        }
      }, status: :ok
    end
  end
  