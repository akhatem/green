class StaticPagesPolicy < ApplicationPolicy
    attr_reader :user, :ctrl
    
    def initialize(user, ctrl)
        @user = user
        @ctrl = ctrl
    end
    
    def index?
        !user.roleKey.eql?("cashier")
    end

    class Scope < Scope
        def resolve
          unless user.roleKey.eql?("cashier")
            scope
          else
            raise Pundit::NotAuthorizedError, 'not allowed to view this action'
          end
        end
      end
end