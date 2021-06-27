class NotificationExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "NotificationExpiryWorker : START"
      Notification.all.where("create_date < ?",  Date.today).where(is_new: true).each do |notification|
          puts "-= Changing notification is_new from #{notification.is_new} =-"
          notification.update_column(:is_new, false)
          puts "-= Changed notification is_new to #{notification.is_new} =-"
      end
      puts "NotificationExpiryWorker : END"
    end
  end
  