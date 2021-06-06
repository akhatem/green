class Api::V1::NotificationsController < ApplicationController
  def index
    notifications =  paginate Notification.all.order(updated_at: :desc)
    if notifications.any?
    
      new_notification = false
      if notifications.where("updated_at = ?", Date.today)
        new_notification = true
      end
      render json: {
        new_notification: new_notification,
        data: notifications.map{ |notification|{
            # title: JSON.parse(notification.title).join(', ').tr(',', ''),
            title: notification.title,
            # description: notification.description.gsub('"', '').gsub('[','').gsub(']','').tr(',', '').strip!,
            description: notification.description.gsub(/\r/, ' ').gsub(/\n/, '').html_safe,
            # .gsub('<p>', '').gsub('</p>', '').gsub(/\r/, ' ').gsub(/\n/, '').gsub(/&nbsp;/, '')
            create_date: notification.create_date
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
      notification = Notification.find(params[:id])  
    rescue
      render json:{
        error: JSON.parse("Notification with id: #{params[:id]} not found!".to_json)
      }, status: :not_found
    else
      render json: {
        data:{
          id: notification.id,
          title: JSON.parse(notification.title).join(', ').tr(',', ''),
          description: notification.description.gsub('"', '').gsub('[','').gsub(']','').tr(',', '').strip!,
          create_date: notification.create_date,
        }
      }, status: :ok
    end
  end
end
  