# == Schema Information
#
# Table name: customers
#
#  id                     :bigint           not null, primary key
#  barcode                :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  mobile                 :string           not null
#  name                   :string           not null
#  password               :string           default(""), not null
#  password_digest        :string           default(""), not null
#  points                 :integer          default(0), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  token                  :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_customers_on_mobile                (mobile) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#  index_customers_on_unlock_token          (unlock_token) UNIQUE
#
require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'

class Customer < ApplicationRecord
  has_secure_password

  include CustomerImageUploader[:barcode] 
  
  
  has_many :points_movements, dependent: :destroy

  validates :mobile, presence: true, allow_blank: false, format: { with: /(01)[0-9]{9}/ }
  validates_format_of :email, :multiline => true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  
  
  before_save :update_customer_data

  def generate_jwt
    JWT.encode({ mobile: mobile, exp: 180.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def generate_barcode
    # byebug
    barcode = Barby::UPCA.new(self.mobile).to_image.to_data_url
    barcode.split(',')[1]
    
  end

  def encode_token(payload)
    JWT.encode(payload, nil)
  end

  def generate_token
    encode_token(self.mobile)
  end

  private
  def update_customer_data
    self.write_attribute(:barcode, self.generate_barcode) 
    self.write_attribute(:token, self.generate_token) 
  end
end
