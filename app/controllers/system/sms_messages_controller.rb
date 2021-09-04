class System::SmsMessagesController < System::SystemApplicationController

  def index
    @pagy, @sms_messages = pagy(policy_scope(SmsMessage.all.order(id: :asc)))
    authorize @sms_messages
  end

  def new
    @sms_message = SmsMessage.new
    authorize @sms_message
  end

  def create
    @sms_message = SmsMessage.new(sms_params)
    authorize @sms_message
    
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
    puts "======> In sms_message_controlelr : mobiles: #{mobiles}"
    mobiles
  end
end
