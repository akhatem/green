require 'json'

class FirebasePushNotification
    def initialize(title, body, image)
        params = {to: topic, notification: { title: title, body: body, image: image }}.to_json
        system("curl -X POST --header 'Authorization: #{authorization}' --Header 'Content-Type: #{content_type}' #{base_uri} -d '#{params}'")
    end

private

    def base_uri
        Rails.application.credentials.firebase[:base_uri]
    end

    def topic
        Rails.application.credentials.firebase[:topic]
    end

    def content_type
        Rails.application.credentials.firebase[:content_type]
    end

    def authorization
        Rails.application.credentials.firebase[:authorization]
    end
end