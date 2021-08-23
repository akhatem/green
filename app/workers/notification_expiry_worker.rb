class NotificationExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "Checking for expired notifictaions..."
      Notification.where("create_date < ?",  Date.today).where(is_new: true).each do |notification|
          notification.update(is_new: false)
          puts "-= Notification #{notification.id} =- is_new changed! =- to #{notification.is_new}"
      end
      puts "Done."
    end
  end
  