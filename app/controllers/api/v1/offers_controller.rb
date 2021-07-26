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
              start_at: offer.start_at.strftime("%d/%m/%Y"),
              end_at: offer.end_at.strftime("%d/%m/%Y"),
              state: offer.state,
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
            start_at: @offer.start_at.strftime("%d/%m/%Y"),
            end_at: @offer.end_at.strftime("%d/%m/%Y"),
            state: @offer.state,
            image: @offer.image.url
          }
        }, status: :ok
      end
    end
  
    def offers_carosel
      offers = Offer.select(:id, :title, :image).order(created_at: :desc).where(state: 1).limit(4)
      offer_carosel_images = OfferCaroselImage.select(:id, :image).order(created_at: :desc).limit(4)

      if offers.any?
        render json:{
          data: offers.map{ |offer|
            {
              id: offer.id,
              title: offer.title,
              image: offer.image.url
              
            }
          }
        }, status: :ok
      else
        render json:{
          data: offer_carosel_images.map{ |offer_carosel_image|
            {
              id: offer_carosel_image.id,
              title: "",
              image: offer_carosel_image.image.url
              
            }
          }
        }, status: :ok
      end
    end
  end


  # render json:{
  #   data: offers.map{ |offer|
  #     {
  #       id: offer.id,
  #       title: offer.title,
  #       image: offer.image.url
        
  #     }
  #   }
  # }, status: :ok
  