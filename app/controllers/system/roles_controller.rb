class System::RolesController < ApplicationController
  def index
    @pagy, @roles = pagy(policy_scope(Role.all.order(id: :asc)))
    authorize @roles

    if params[:search]
      @search_term = params[:search]
      @roles = @roles.search_by(@search_term)
    end
  end

  def show
    @role = Role.find(params[:id])
    authorize @role
  end
end
