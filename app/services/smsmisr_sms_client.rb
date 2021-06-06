require 'uri'

class SmsmisrSmsClient
    def initialize(message, *mobile)
        
        client = HTTPClient.new
    
        params = 
        "username=#{username}" +
        "&password=#{password}" +
        "&language=#{language}" +
        "&sender=#{sender}" +
        "&mobile=#{mobile}" +
        "&message=#{message}"

        # puts "params: #{params}"
        connection = client.post_async(uri, params)
        # puts "connection: #{connection}"
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
        "https://smsmisr.com/api/v2/?"
    end

    def username
        Rails.application.credentials.smsmisr[:username]
    end
    
    def password
        Rails.application.credentials.smsmisr[:password]
    end

    def language
        Rails.application.credentials.smsmisr[:sms][:language]
    
    end

    def sender
        Rails.application.credentials.smsmisr[:sms][:sender]
        
    end
end