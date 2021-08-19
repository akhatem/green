# frozen_string_literal: true
class System::UsersController < Devise::SessionsController
    before_action :authenticate_system_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @users = pagy(User.all.order(id: :asc))
      if params[:search]
        @search_term = params[:search]
        @users = @users.search_by(@search_term)
      end

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "#{params[:controller].split('/').second}_#{DateTime.now.strftime('%d/%m/%Y')}", 
            template: "system/#{params[:controller].split('/').second}/#{params[:controller].split('/').second}_index_pdf.html.erb"
        end
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to system_users_index_path, notice: "#{@user.name} was updated successfully." }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @user.destroy
          format.html { redirect_to system_users_index_path, notice: "User was destroyed successfully." }
          format.json { head :no_content }
        end
      end
    end
  
    # GET /resource/sign_in
    def login
      super
    end

    def new_user
      @user = User.new
    end
  
    # POST /resource/sign_in
    def create_user
      @user = User.new(user_params)
      if @user.valid?
        @user.save
        redirect_to system_users_index_path
        flash[:notice] = "User created successfully."
      else
        render :new_user
        flash[:alert] = "Error creating user!"
      end
      # super
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

    private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role_id, :branch_id)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
  