class BranchPolicy < ApplicationPolicy
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
