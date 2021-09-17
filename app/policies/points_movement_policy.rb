class PointsMovementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      unless user.roleKey.eql?("cashier")
        scope.all
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end

  def daily_points_movements?
    !@user.roleKey.eql?("cashier")
  end
end
