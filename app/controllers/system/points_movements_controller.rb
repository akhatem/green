class System::PointsMovementsController < ApplicationController
  def index
    @pagy, @points_movements = pagy(PointsMovement.all.order(id: :asc))
    if params[:search]
      @search_term = params[:search]
      @points_movements = @points_movements.search_by(@search_term)
    end
  end

  def show
  end
end
