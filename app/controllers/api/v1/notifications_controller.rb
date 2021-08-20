class Api::V1::NotificationsController < ApplicationController
  def index
    notifications =  paginate Notification.all.order(updated_at: :desc)
    if notifications.any?
      render json: {
        data: notifications.map{ |notification|{
            title: notification.title,
            offer_id: notification.offer_id ? notification.offer_id : nil,
            description: notification.description.gsub(/\r/, ' ').gsub(/\n/, '').html_safe,
            create_date: notification.create_date.strftime("%d/%m/%Y"),
            is_new: notification.is_new ? true : false
          }
        }
      }, status: :ok
    else
      render json:{
        error: JSON.parse("No notifications found!".to_json)
      }, status: :not_found
    end
  end

  def show
    begin
      @notification = Notification.find(params[:id])
    rescue
      render json:{
        error: JSON.parse("No notification found with id: #{params[:id]}".to_json)
      }, status: :not_found
      
    else
      render json: {
        data:{
          title: @notification.title,
          offer_id: @notification.offer_id ? @notification.offer_id : nil,
          image: @notification.image.url,
          description: @notification.description,
          is_new: @notification.is_new ? true : false
        }
      }, status: :ok
    end
  end

end
  