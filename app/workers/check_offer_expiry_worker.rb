class CheckOfferExpiryWorker
    include Sidekiq::Worker
    
    def perform
      puts "Checking for expired offers..."
      Offer.where(state: 1).each do |offer|
        puts "=============================================="
        puts "offer end_at to_s date_time: #{offer.end_at.to_datetime}"
        puts "Time current to datetime: #{Time.current.to_datetime}"
        puts "offer end_at <= Time.current.now: #{offer.end_at.to_datetime <= Time.current.to_datetime}"
        puts "=============================================="
        if offer.end_at.to_datetime <= Time.current.to_datetime
          offer.update(state: 0)
          puts "-= Offer #{offer.id} =- state changed to #{offer.state}!"
        end
      end
      puts "Done."
    end
  end
