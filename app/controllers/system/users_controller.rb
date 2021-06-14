# frozen_string_literal: true
class System::UsersController < System::SessionsController
    before_action :authenticate_system_user!
  
    # GET /resource/sign_in
    def login
      super
    end
  
    # POST /resource/sign_in
    def create
      redirect_to root_path
      # super
    end

    def after_sign_in_path_for
      root_path
    end
  
    # DELETE /resource/sign_out
    # def logout
      # super
    # end
  
    # protected
  
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
  