# frozen_string_literal: true
class System::UsersController < System::SessionsController
    before_action :authenticate_system_user!

    def index
      @pagy, @users = pagy(User.all.order(id: :asc))  
    end
  
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
  