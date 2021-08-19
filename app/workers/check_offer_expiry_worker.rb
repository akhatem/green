class CheckOfferExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "Checking for expired offers..."
      Offer.all.where("end_at < ?", Time.now).where(state: 1).each do |offer|
          offer.update(state: 0)
          puts "-= Offer #{offer.id} =- state changed to #{offer.state}!"
      end
      puts "Done."
    end
  end
  