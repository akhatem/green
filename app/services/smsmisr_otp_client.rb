require 'uri'

class SmsmisrOtpClient
    def initialize(mobile, code)
           
        client = HTTPClient.new
        
        params = 
        "username=#{username}" +
        "&password=#{password}" +
        "&msignature=#{msignature}" +
        "&token=#{token}" +
        "&mobile=#{mobile}" +
        "&Code=#{code}"


        puts "params: #{params}" 
        connection = client.post_async(uri, query: params, body: {})
        # # puts "connection: #{connection}"
        print 'posting.'
        while true
            break if connection.finished?
            print '.'
            sleep 1
        end
        puts '.'
        res = connection.pop
        puts res.status
        puts res.content.read
    end

private

    def uri
        "https://smsmisr.com/api/vSMS/?"
    end

    def username
        Rails.application.credentials.smsmisr[:username]
    end
    
    def password
        Rails.application.credentials.smsmisr[:password]
    end

    def msignature
        Rails.application.credentials.smsmisr[:otp][:msignature]
    end

    def token
        Rails.application.credentials.smsmisr[:otp][:token]
    end
end