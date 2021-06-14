# == Schema Information
#
# Table name: customers
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  mobile            :string           not null
#  password          :string           default(""), not null
#  password_digest   :string           default(""), not null
#  email             :string
#  token             :string
#  barcode           :string
#  points            :integer          default(0), not null
#  is_active         :boolean          default(FALSE), not null
#  verification_code :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'


class Customer < ApplicationRecord
  has_secure_password
  
  has_many :points_movements, dependent: :destroy

  validates :mobile, presence: true, allow_blank: false, format: { with: /(01)[0-9]{9}/ }
  validates_format_of :email, :multiline => true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
   
  mount_uploader :barcode, CustomerBarcodeUploader
  
  before_create :add_customer_data

  private

  def generate_jwt
    JWT.encode({ mobile: mobile, exp: 180.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def encode_token(payload)
    JWT.encode(payload, nil)
  end
  
  def generate_token
    encode_token(self.mobile)
  end

  def generate_barcode
    brcode = Barby::UPCA.new(self.mobile).to_image.to_data_url
    brcode.split(',')[1]
    puts "barcode: #{brcode.split(',')[1]}"
  end
  
  def add_customer_data
    self.write_attribute(:token, generate_token)
    self.write_attribute(:barcode, generate_barcode)
  end
end

