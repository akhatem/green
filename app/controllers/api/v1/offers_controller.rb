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
            start_at: offer.start_at.strftime("%l:%M %P  %d/%m/%Y"),
            end_at: offer.end_at.strftime("%l:%M %P %d/%m/%Y"),
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
          start_at: @offer.start_at.strftime("%l:%M %P %d/%m/%Y"),
          end_at: @offer.end_at.strftime("%l:%M %P %d/%m/%Y"),
          state: @offer.state,
          image: @offer.image.url
        }
      }, status: :ok
    end
  end

  def offers_carosel
    offers_images = []
    offers = Offer.select(:id, :title, :image).order(created_at: :desc).where(state: 1).limit(4)
    offer_carosel_images = OfferCaroselImage.select(:id, :image).order(created_at: :desc).limit(4)
    offers.all.each do |offer|
      offers_images.push(offer)
    end
    
    if offers_images.size.eql?(4)
       render json: {
          data: offers_images.map{ |offers_image|
             {
                id: offers_image.id,
                title: offers_image.has_attribute?("title") ? offers_image.title : "",
                image: offers_image.image.url
             }
          }
       }, status: :ok
    else

      offer_carosel_images.all.each do |offer_carosel_image|
        offers_images.push(offer_carosel_image)
      end
      
      render json: {
        data: offers_images.map{ |offers_image|
           {
              id: offers_image.id,
              title: offers_image.has_attribute?("title") ? offers_image.title : "",
              image: offers_image.image.url
           }
        }
     }, status: :ok
    end
  end    
end