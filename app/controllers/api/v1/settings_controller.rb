class Api::V1::SettingsController < ApplicationController
  
  def about_us
    about_us = Setting.find_by(name: "About Us")
    render json: {
        data: JSON.parse(about_us.description.gsub("\n", "").to_json)
      }
  end

  def contact_us
    contact_us = Setting.find_by(name: "Contact Us")
    render json:{
      data: {
        message: JSON.parse("For inquries please contact us on WhatsApp".to_json),
        whatsapp: JSON.parse("+2#{contact_us.description}".to_json)
      }
    }, status: :ok
  end
end
