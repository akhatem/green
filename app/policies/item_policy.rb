class ItemPolicy < ApplicationPolicy


  class Scope < Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
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
