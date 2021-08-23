class Api::V1::PushNotificationsController < ApplicationController
    def index
        notification_update_date = Notification.where("updated_at <= ?", DateTime.now - 10.seconds).last.update_date
        push_notification =  PushNotification.where("updated_at = ?", notification_update_date)
        if push_notification
            render json: {
                data: 
                {
                    title: push_notification.title,
                    description: push_notification.description.gsub(/\r/, ' ').gsub(/\n/, '').html_safe,
                    image: push_notification.image.url ? push_notification.image.url : "",
                    notification_id: push_notification.notification_id
                }
            }, status: :ok
        else
          render json:{
            error: JSON.parse("No push notifications found!".to_json)
          }, status: :not_found
        end
    end
end

    