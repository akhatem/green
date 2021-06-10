# == Schema Information
#
# Table name: customers
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  mobile              :string           not null
#  password            :string           default(""), not null
#  password_digest     :string           default(""), not null
#  email               :string
#  token               :string
#  barcode             :text
#  points              :integer          default(0), not null
#  is_activated?       :boolean          default(FALSE), not null
#  verification_code   :string           not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'

class Customer < ApplicationRecord
  has_secure_password

  include CustomerBarcodeUploader[:barcode] 
  

  belongs_to :sms_message
  
  has_many :points_movements, dependent: :destroy

  validates :mobile, presence: true, allow_blank: false, format: { with: /(01)[0-9]{9}/ }
  validates_format_of :email, :multiline => true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  
  
  before_save :update_customer_data

  def generate_jwt
    JWT.encode({ mobile: mobile, exp: 180.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def generate_barcode
    barcode = Barby::UPCA.new(self.mobile).to_image.to_data_url
    barcode.split(',')[1]
    puts "barcode: #{barcode}"
  end

  def encode_token(payload)
    JWT.encode(payload, nil)
  end

  def generate_token
    encode_token(self.mobile)
  end

  private
  def update_customer_data
    self.write_attribute(:barcode_data, self.generate_barcode) 
    self.write_attribute(:token, self.generate_token) 
  end
end
