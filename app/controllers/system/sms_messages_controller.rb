class System::SmsMessagesController < System::SystemApplicationController

    def index
        @pagy, @sms_messages = pagy(SmsMessage.all.order(created_at: :desc))
    end

    def new
        @sms_message = SmsMessage.new
    end

    def create
      @sms_message = SmsMessage.new(sms_params)
      
      respond_to do |format|
        if @sms_message.save
          SmsmisrSmsClient.new(sms_params[:message].to_s, customers_mobile)
          format.json { render :index, status: :created }
          format.html { redirect_to system_sms_messages_path, notice: "SMS was successfully sent." }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @sms_message.errors, status: :unprocessable_entity }
              
          end
        end
    end


    private

  def sms_params
      params.require(:sms_message).permit(:message)
  end

  private
    def customers_mobile
      mobiles = ""
      Customer.all.each do |customer|
        if customer == Customer.last
          mobiles << "#{customer.mobile}"
        else
          mobiles << "#{customer.mobile},"
        end
      end
      mobiles = mobiles.gsub(/\[\"/, '').gsub(/\"\]/, '') 
      mobiles
    end
end
