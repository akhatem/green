class System::SmssController < ApplicationController

#   def index
#     @pagy, @smss = pagy(Sms.all.order(id: :desc))
#   end

#     #TODO WORKING

#     def send_sms
#         SmsmisrSmsClient.new("Welcome to Green Cafe", select_all_customers)
#     end


#     private
#     def select_all_customers
#         mobiles = ""
#         Customer.all.each do |customer|
#           if customer == Customer.last
#             mobiles << "#{customer.mobile}"
#           else
#             mobiles << "#{customer.mobile},"
#           end
#         end
#         mobiles = mobiles.gsub("[\"", '').gsub("\"]", '')
#         return mobiles
#       end
end
