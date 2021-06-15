class Api::V1::ItemsController < ApplicationController
  
  def index
     items = paginate Item.all.where(brand_id: params[:brand_id], category_id: params[:category_id])
     if items.any?
     render json: {
        message: JSON.parse("List of item(s) in category: #{Category.find(params[:category_id]).name}".to_json),
        data: items.map{ |item|
           {
           id: item.id,
           name: item.name,
           image: item.image_url,
           sizes: item.sizes.map{ |size| 
              { 
                 name: size.name, 
                 price: size.price 
              } 
           }
         }
        } 
     }, status: :ok
     else
        render json:{
           message: JSON.parse("No items found!".to_json),
           error: JSON.parse("No items found in category: #{Category.find(params[:category_id]).name}".to_json)
        }, status: :not_found
     end
  end

  def show
     begin
        item = Item.find_by(brand_id: params[:brand_id], category_id: params[:category_id], id: params[:item_id])  
     rescue
        render json: {
           message: JSON.parse("Item not found!".to_json),
           error: JSON.parse("Item with id: #{params[:item_id]} not found!".to_json)
        }, status: :not_found
     else
        render json: {
           message: JSON.parse("Item details".to_json),
           data:
           {
           id: item.id,
           name: item.name,
           brand: item.brandName,
           category: item.categoryName,
           image: item.image_url,
           sizes: item.sizes.map{ |size| 
              { 
                 name: size.name, 
                 price: size.price 
              } 
           },
           descirption: item.description
           }
        }, status: :ok
     end
  end

  def latest
     items = Item.select(:id, :image_data, :name).order(created_at: :desc).limit(5).where(brand_id: params[:brand_id])
     if items.any?
     render json: {
        message: JSON.parse("List of latest item(s) for brand: #{Brand.find(params[:brand_id]).name}".to_json),
        data: items.map{ |item|
           {
           id: item.id,
           name: item.name,
           image: item.image_url
           }
        }
     }, status: :ok
     else
        render json: {
           message: JSON.parse("Items not found!".to_json),
           error: JSON.parse("No new items in brand #{Brand.find(params[:brand_id]).name}!".to_json)
        }, status: :not_found
     end
  end


# private
#   def item_params
#      params.require(:item).permit(size_ids: [])
#   end
end
