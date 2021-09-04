class UserPolicy < ApplicationPolicy

  def new_user?
    !user.roleKey.eql?("cashier")
  end

  def create_user?
    !user.roleKey.eql?("cashier")
  end

  def destroy_user?
    !user.roleKey.eql?("cashier")
  end
  class Scope < Scope
    def resolve
      unless user.roleKey.eql?("cashier")
        scope.all
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end
end
