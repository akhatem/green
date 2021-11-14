# frozen_string_literal: true
class UsersController < Devise::SessionsController
  before_action :authenticate_user!
  before_action :set_custom_user, only: [:show, :edit, :update, :destroy_user]

  # Devise methods
  
  def login
    redirect_to new_user_session_path and return
  end # Devise methods

  # Custom User methods

  def index
    @pagy, @users = pagy(policy_scope(User.all.order(id: :asc)))
    authorize @users
    if params[:search]
      @search_term = params[:search]
      @users = @users.search_by(@search_term)
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "users/users_index_pdf_#{DateTime.now.strftime('%d/%m/%Y')}", 
          template: "users/users_index_pdf.html.erb",
          header: { right: "#{@pagy.page} of #{@pagy.last}" }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
      if @user.update(user_params)
        redirect_to users_index_path
        flash[:notice] =  "#{@user.name} was updated successfully."
      else
        flash[:alert] = @user.errors, status: :unprocessable_entity
        render :edit
      end
    end
  end

  def new_user
    @user = User.new
    authorize current_user
  end

  def create_user
    @user = User.new(user_params)
    authorize current_user
    if @user.valid?
      @user.save
      redirect_to users_index_path
      flash[:notice] = "User created successfully."
    else
      flash.now[:alert] = "Error creating user!"
      render :new_user
    end
  end

  def destroy_user
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_index_path, notice: "User was removed successfully." }
        format.json { head :no_content }
      end
    end
  end # Custom user methods

  protected
  
  # Devise methods
    def after_sign_in_path_for(resource)
      if current_user.roleKey.eql?("cashier")
        cashier_path
      else
        system_root_path
      end
    end # Devise methods
  
  private

  def set_custom_user
    @user = User.find(params[:id])
    authorize current_user
  end
    
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :role_id, :branch_id)
  end
end
  