class CheckOfferExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "Checking for expired offers..."
      Offer.where("end_at <= ?", DateTime.now.to_s(:date_time)).where(state: 1).each do |offer|
          offer.update(state: 0)
          puts "-= Offer #{offer.id} =- state changed to #{offer.state}!"
      end
      puts "Done."
    end
  end
  