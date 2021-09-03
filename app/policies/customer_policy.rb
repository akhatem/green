class CustomerPolicy < ApplicationPolicy
  class Scope < Scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def index?
      !user.roleKey.eql?("cashier")
    end

    def show?
      !user.roleKey.eql?("cashier")
    end
  
    def resolve
      scope.all
    end
  end
end
