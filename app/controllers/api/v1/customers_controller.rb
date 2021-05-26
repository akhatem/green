require 'json'

class Api::V1::CustomersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    if Customer.find_by(mobile: create_params[:mobile])
      render json: {
        error: JSON.parse(['Mobile number already taken!'].to_json)
        }, status: :not_acceptable
    else
      @customer = Customer.create(create_params)
      if @customer.valid?
        render json: {
          message: JSON.parse(['Customer Created Successfully.'].to_json),
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

  # LOGGING IN
  def login
    if params[:mobile] && params[:password]
      @customer = Customer.find_by(mobile: params[:mobile])
      if @customer &.authenticate(params[:password])
        render json: {
          message: JSON.parse(['Logged in successfully.'].to_json),
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
          error: JSON.parse(['Invalid mobile number or password!'].to_json)
        }, status: :bad_request
      end
    else
      render json: {
        error: JSON.parse(['Invalid mobile number or password!'].to_json)
      }, status: :bad_request
    end
  end

  def forgot
    @customer = Customer.find_by(email: params[:_json])
    if @customer
      render json: {
        alert: 'If this customer exists, we have sent you a password reset email.'
      }
      @customer.send_password_reset
    else
      # this sends regardless of whether there's an email in database for security reasons
      render json: {
        alert: 'If this customer exists, we have sent you a password reset email.'
      }
    end
  end

  def reset
    @customer = Customer.find_by(password_reset_token: params[:token], email: params[:email])
    if @customer&.password_token_valid?
      if @customer.reset_password(params[:password])
        render json: {
          alert: 'Your password has been successfuly reset!'
        }
        session[:customer_id] = @customer.id
      else
        render json: {
          error: @customer.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: {
        error: JSON.parse(['Link not valid or expired. Try generating a new link.'].to_json)
      }, status: :not_found
    end
  end

  def auto_login
    render json: @customer
  end

  # SHOW
  def show
    begin
      if logged_in? && header_token
        @customer = Customer.find_by(token: header_token)
      end
    rescue
      render json: { 
        error: JSON.parse(['Unauthorized request!'].to_json)
        }, status: :unauthorized
    else
      render json: {
        message: JSON.parse(['Customer details.'].to_json),
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
        error: JSON.parse(['No content!'].to_json)
      }, status: :no_content
    else
      if !header_token || Customer.find_by(token: header_token).nil?
        render json: { 
          error: JSON.parse(['Unauthorized request!'].to_json),
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

        if @customer.valid?
          @customer.save

          render json: {
            message: JSON.parse(['Profile updated successfully.'].to_json),
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
end