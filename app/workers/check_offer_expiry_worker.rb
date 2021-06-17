class CheckOfferExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "CheckOfferExpiryWorker : START"
      Offer.all.where("end_at < ?",  Date.today).where(state: 1).each do |offer|
          puts "-= Changing offer state from #{offer.state} =-"
          offer.update_column(:state, 0)
          puts "-= Changed offer state to #{offer.state} =-"
      end
      puts "CheckOfferExpiryWorker : END"
    end
  end
  