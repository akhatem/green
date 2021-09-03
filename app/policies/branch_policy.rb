class BranchPolicy < ApplicationPolicy
  class Scope < Scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def index?
      !user.roleKey.eql?("cashier")
    end

    def show?
      !user.roleKey.eql?("admin")
    end
  
    def resolve
      puts "Scope: #{scope}"
      # if user.roleName.eql?("super")
      scope.all
      # elsif user.roleName.eql?("admin")
        
      # end
    end
  end
end
