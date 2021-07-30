class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    !@user.roleKey.eql?("Cashier")
  end

  def show?
    # false
    !user.roleKey.eql?("admin")
  end

  def create?
    false
    # !@user.role.name.eql?("Cashier")
  end

  def new?
    create?
    # !@user.role.name.eql?("Cashier")
  end

  def update?
    false
    # !@user.role.name.eql?("Cashier")
  end

  def edit?
    update?
  end

  def destroy?
    false
    # !@user.role.name.eql?("Cashier")
  end

  def barcode_search?
    false
    # @user.role.name.eql?("Cashier")
  end

  def customer_info?
    false
  end

  def redeem_points?
    false
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
