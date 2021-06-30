# == Schema Information
#
# Table name: customers
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  mobile               :string           not null
#  password             :string           default(""), not null
#  password_digest      :string           default(""), not null
#  email                :string
#  token                :string
#  barcode              :string
#  points               :integer          default(0), not null
#  is_activated?        :boolean          default(FALSE), not null
#  verification_code    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  decoded_barcode      :binary
#  has_new_notification :boolean          default(FALSE)
#

require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'


class Customer < ApplicationRecord
  has_secure_password
  
  has_many :points_movements, dependent: :destroy

  validates :mobile, presence: true, allow_blank: false, format: { with: /(01)[0-9]{9}/ }
  validates_format_of :email, :multiline => true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
   
  
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

  def generate_barcode_token
    encode_token(self.mobile + self.name)
  end

  def generate_barcode
    sub_token = generate_barcode_token[0...-11]
    brcode = Barby::Code128B.new(sub_token).to_image.to_data_url
    splitted_barcode = brcode.split(',')[1]
    self.write_attribute(:decoded_barcode, sub_token)

    return splitted_barcode
  end

  def add_customer_data
    self.write_attribute(:token, generate_token)

    generated_barcode = generate_barcode
    self.write_attribute(:barcode, generated_barcode)
  end
end
