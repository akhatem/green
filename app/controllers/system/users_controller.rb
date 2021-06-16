# frozen_string_literal: true
class System::UsersController < Devise::SessionsController
    before_action :authenticate_system_user!

    def index
      @pagy, @users = pagy(User.all.order(id: :asc))
    end

    def show
      @customer = Customer.find(params[:id])
    end

    def edit
    end

    def update
      @customer = Customer.find(params[:id])
      respond_to do |format|
        if @customer.update(customer_params)
          format.html { redirect_to system_users_index_path, notice: "#{@customer.name} was successfully updated." }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end

    def 
  
    # GET /resource/sign_in
    def login
      super
    end
  
    # POST /resource/sign_in
    def create
      super
      # after_sign_in_path_for
    end

    # def after_sign_in_path_for
    #   redirect_to system_root_path
    # end

    def after_sign_out_path_for
      redirect_to new_system_user_session_path
    end
  
    # DELETE /resource/sign_out
    def logout
      after_sign_out_path_for
      super
    end

    # protected
  
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
  