class UserPolicy < ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new_user?
    !@user.roleKey.eql?("cashier")
  end

  def create_user?
    !@user.roleKey.eql?("cashier")
  end

  def destroy_user?
    !@user.roleKey.eql?("cashier")
  end
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      unless @user.roleKey.eql?("cashier")
        @scope.all
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end
end
