class ReceiptPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    @user.roleKey.eql?("cashier")
  end

  def new?
    create?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
  class Scope < Scope
    attr_reader :user, :scope
  
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end 
end
