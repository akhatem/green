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
           image: item.image.url,
           sizes: item.sizes.map{ |size| 
              { 
                 name: size.name, 
                 price: size.price.round(2)
              } 
           }
         }
        } 
     }, status: :ok
     else
        render json:{
           error: JSON.parse("No items found in category: #{Category.find(params[:category_id]).name}".to_json)
        }, status: :not_found
     end
  end

  def show
     begin
        item = Item.find_by(brand_id: params[:brand_id], category_id: params[:category_id], id: params[:item_id])  
     rescue
        render json: {
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
           image: item.image.url,
           sizes: item.sizes.map{ |size| 
              { 
                 name: size.name, 
                 price: size.price.round(2) 
              } 
           },
           descirption: item.description
           }
        }, status: :ok
     end
  end

  def popular_items
      categories = Category.all.where(brand_id: params[:brand_id]).where.not("name = ? OR name = ?", "Extras", "Other Beverage")
      if categories.any?
         render json: {
            message: JSON.parse("Popular item(s) for brand: #{Brand.find(params[:brand_id]).name}".to_json),
            data:
            categories.map{ |category|
               items = Item.all.where(category_id: category.id)
               items.limit(2).map{ |item| 
                  {
                     id: item.id,
                     name: item.name,
                     category: item.categoryName,
                     image: item.image.url
                  }
               }
            }
         }, status: :ok
      else
         render json: {
            error: JSON.parse("No categories found in brand #{Brand.find(params[:brand_id]).name}!".to_json)
         }, status: :not_found
      end
  end
end
