class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    !@user.roleKey.eql?("cashier")
  end

  def show?
    !@user.roleKey.eql?("cashier")
  end

  def create?
    !@user.roleKey.eql?("cashier")
  end

  def new?
    create?
  end

  def update?
    !@user.roleKey.eql?("cashier")
  end

  def edit?
    update?
  end

  def destroy?
    !@user.roleKey.eql?("cashier")
  end

  def barcode_search?
    false
    # @user.roleKey.eql?("cashier")
  end

  def customer_info?
    false
    # @user.roleKey.eql?("cashier")
  end

  def redeem_points?
    false
    # @user.roleKey.eql?("cashier")
  end


  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
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
