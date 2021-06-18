class Api::V1::CustomersController < ApplicationController
  protect_from_forgery with: :null_session
  
  before_action :set_customer, only: [:login, :verify_account, :show, :forgot_password, :reset_password, 
    :forgot_password_mobile, :forgot_password_verification_code, :password_reset, :resend_verification_code]
  

  # REGISTER
  def create
    if Customer.find_by(mobile: create_params[:mobile])
      render json: {
        error: JSON.parse("Mobile number already taken!".to_json)
        }, status: :not_acceptable
    else
      generated_code = generate_verification_code
      @customer = Customer.new(create_params)
      @customer.update(verification_code: generated_code)
      if @customer.valid?
        SmsmisrOtpClient.new(@customer.mobile, generated_code)
        render json: {
          message: JSON.parse("Account Created Successfully.".to_json),
          data: {
            id: @customer.id,
            name: @customer.name,
            mobile: @customer.mobile,
            token: @customer.token
          }
        }, status: :ok
      else
        render json: {
          error: @customer.errors.full_messages
        }, status: :not_acceptable
      end
    end
  end

  def verify_account
    if @customer
      if @customer.verification_code.eql?(verify_account_params[:verification_code])
        @customer.update(is_activated: true)
        render json: {
          message: JSON.parse("Account verified successfully.".to_json),
        }, status: :ok
      else
        render json: {
          error: JSON.parse("Incorrect verification code!".to_json)
          }, status: :not_acceptable
      end
    else
      render json: {
        error: JSON.parse("Account not found!".to_json)
      }, status: :not_acceptable
    end
  end

  def resend_verification_code
    if @customer
      generated_code = generate_verification_code
      if SmsmisrOtpClient.new(@customer.mobile, generated_code)
        @customer.update(verification_code: generated_code)
        render json: {
          message: JSON.parse("Verification code resent.".to_json),
        }, status: :ok
      else
        render json: {
          error: JSON.parse("Unable to resend verification code!".to_json)
        }, status: :bad_request
      end
    else
      render json: {
        error: JSON.parse("Account not found!".to_json)
      }, status: :not_acceptable
    end
    
  end

  # LOGGING IN
  def login
    if params[:mobile] && params[:password]
      if @customer
        if @customer.is_activated
          if @customer.authenticate(params[:password])
            render json: {
              message: JSON.parse("Logged in successfully.".to_json),
              data: {
                id: @customer.id,
                name: @customer.name,
                mobile: @customer.mobile,
                email: @customer.email,
                token: @customer.token
              }
            }, status: :ok
          else
            render json: {
              error: JSON.parse("Incorrect mobile number or password!".to_json)
            }, status: :bad_request
          end
        else
          render json: {
            error: JSON.parse("Account not verified!".to_json),
            }, status: :not_acceptable
        end
      else
        render json: {
          error: JSON.parse("Account not found!".to_json)
        }, status: :not_acceptable
      end
    else
      render json: {
        error: JSON.parse("Invalid mobile number or password!".to_json)
      }, status: :bad_request
    end
  end

  def password_reset
    if @customer
      @customer.update(password: params[:password])
      render json: {
        message: JSON.parse("Password reset Successful.".to_json),
      }, status: :ok
      else
        render json: { 
          error: JSON.parse("Unauthorized request!".to_json),
        }, status: :unauthorized
    end
  end

  def forgot_password_verification_code
    if @customer.verification_code.eql?(params[:verification_code])
      render json: {
        message: JSON.parse("Verification Successful.".to_json),
      }, status: :ok
    else
      render json: {
        error: JSON.parse("Incorrect verification code!".to_json)
      }, status: :not_acceptable
    end
  end

  def forgot_password_mobile
    begin
      @customer
    rescue
      render json: {
        error: JSON.parse("Account not found!".to_json)
      }, status: :not_acceptable
    else
      if @customer
        generated_code = generate_verification_code
        SmsmisrOtpClient.new(@customer.mobile, generated_code)
        @customer.update(verification_code: generated_code)
        render json: {
          message: JSON.parse("Verification code sent to mobile #{@customer.mobile}.".to_json), 
        }, status: :ok 
      else
        render json: { 
          error: JSON.parse("Unauthorized request!".to_json),
        }, status: :unauthorized
      end
    end
  end

  # SHOW
  def show
    begin
      if logged_in? && header_token
        @customer = Customer.find_by(token: header_token)
      end
    rescue
      render json: { 
        error: JSON.parse("Unauthorized request!".to_json)
        }, status: :unauthorized
    else
      render json: {
        message: JSON.parse("Customer details.".to_json),
        data: {
          name: @customer.name,
          mobile: @customer.mobile,
          email: @customer.email,
          points: @customer.points,
          barcode: @customer.barcode
        }
      }, status: :ok
    end
  end

  # Update
  def update
    begin
      update_params.empty?
    rescue
      render json: {
        error: JSON.parse("No content!".to_json)
      }, status: :no_content
    else
      if !header_token || Customer.find_by(token: header_token).nil?
        render json: { 
          error: JSON.parse("Unauthorized request!".to_json),
        }, status: :unauthorized   
      else
        @customer = Customer.find_by(token: header_token)
        
        if update_params[:name]
          @customer.write_attribute(:name, update_params[:name])
        end
        
        if update_params[:mobile] && (update_params[:mobile] != @customer.mobile)
            new_token = @customer.encode_token(update_params[:mobile])
            @customer.write_attribute(:token, new_token)
            @customer.write_attribute(:mobile, update_params[:mobile]) 
        end
        
        if update_params[:email]
          @customer.write_attribute(:email, update_params[:email])
        end
        
        if update_params[:password]
          @customer.write_attribute(:password, update_params[:password])
        end

        if @customer.save
          render json: {
            message: JSON.parse("Profile updated successfully.".to_json),
            data: {
              name: @customer.name,
              mobile: @customer.mobile,
              email: @customer.email,
              token: @customer.token
            }
          }, status: :ok
        else
          render json: {
            error: @customer.errors.full_messages
          }, status: :not_acceptable
        end
      end
    end
  end

  private

  def create_params
    params.require(:customer).permit(:name, :email, :password, :password_digest, :mobile)
  end

  def update_params
    params.require(:customer).permit(:name, :email, :password, :mobile)
  end

  def verify_account_params
    params.require(:customer).permit(:token, :verification_code)
  end

  def set_customer
    if header_token
      @customer = Customer.find_by(token: header_token)
    elsif params[:mobile]
      @customer = Customer.find_by(mobile: params[:mobile])
    end
  end
end