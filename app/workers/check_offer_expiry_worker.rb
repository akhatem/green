class CheckOfferExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "Checking for expired offers..."
      Offer.where(state: 1).each do |offer|
        puts "=============================================="
        puts "offer end_at to_s date_time: #{offer.end_at.to_s(:date_time)}"
        puts "Date Time now to_s date_time: #{DateTime.now.to_s(:date_time)}"
        puts "offer end_at <= DateTime.now: #{offer.end_at.to_s(:date_time) <= DateTime.now.to_s(:date_time)}"
        puts "=============================================="
        if offer.end_at.to_s(:date_time) <= DateTime.now.to_s(:date_time)
          offer.update(state: 0)
          puts "-= Offer #{offer.id} =- state changed to #{offer.state}!"
        end
      end
      puts "Done."
    end
  end
  